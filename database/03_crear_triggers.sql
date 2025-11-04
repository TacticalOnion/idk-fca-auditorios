SET client_encoding to 'UTF8';
BEGIN;

--------------------------------------------------------
/*
nombre: fun_default_fecha_fin
descripcion: 
        Establece fecha_fin igual a fecha_inicio si no se proporciona fecha_fin 
        al insertar un nuevo evento.
disparador: trg_default_fecha_fin
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_default_fecha_fin()
RETURNS TRIGGER AS $$
BEGIN
        -- Si fecha_fin no se proporciona, se copia fecha_inicio
        IF NEW.fecha_fin IS NULL THEN
                NEW.fecha_fin := NEW.fecha_inicio;
        END IF;
        RETURN NEW;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_default_fecha_fin ON public.evento;

CREATE TRIGGER trg_default_fecha_fin
BEFORE INSERT ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_default_fecha_fin();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_default_fecha_fin()
IS 'Función disparada por trg_default_fecha_fin. Establece fecha_fin igual a fecha_inicio por default';
-- trigger
COMMENT ON TRIGGER trg_default_fecha_fin ON public.evento
IS 'Establece fecha_fin igual a fecha_inicio si no se proporciona fecha_fin al insertar un nuevo evento'; 
---------------------------------------------------------
/*
nombre: fun_default_id_calendario_escolar_evento
descripcion: 
        Establece id_calendario_escolar por default el valor del id del
        ultimo calendario_escolar que contenga el rango del evento. Si el usuario
        proporciona un id_calendario_escolar, valida que el rango del evento
disparador: trg_default_id_calendario_escolar_evento
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_default_id_calendario_escolar_evento()
RETURNS TRIGGER AS $$
DECLARE
        v_id_cal SMALLINT;
        v_inicio DATE;
        v_fin        DATE;
BEGIN
        -- Normalizamos fechas (por si en UPDATE vienen alteradas)
        v_inicio := NEW.fecha_inicio;
        v_fin        := NEW.fecha_fin;

        -- Validación básica de rango por si el CHECK aún no se ha aplicado
        IF v_inicio > v_fin THEN
                RAISE EXCEPTION 'fecha_inicio (%) no puede ser mayor que fecha_fin (%)', v_inicio, v_fin
                        USING ERRCODE = '22007'; -- invalid_datetime_format / similar
        END IF;

        -- Caso A: El usuario NO proporciona id_calendario_escolar (o lo deja NULL)
        IF NEW.id_calendario_escolar IS NULL THEN
                -- Elegimos el "último" calendario que contenga por completo el rango del evento:
                SELECT id_calendario_escolar
                    INTO v_id_cal
                    FROM public.calendario_escolar
                 WHERE semestre_inicio <= v_inicio
                     AND v_fin                     <= semestre_fin
                 ORDER BY id_calendario_escolar DESC
                 LIMIT 1;

                IF v_id_cal IS NULL THEN
                        RAISE EXCEPTION
                            'No existe un calendario_escolar cuyo rango [% - %] contenga el rango del evento [% - %]',
                            (SELECT MIN(semestre_inicio) FROM public.calendario_escolar),
                            (SELECT MAX(semestre_fin) FROM public.calendario_escolar),
                            v_inicio, v_fin
                            USING ERRCODE = '23514'; -- check_violation
                END IF;

                NEW.id_calendario_escolar := v_id_cal;

        ELSE
        -- Caso B: El usuario SÍ proporciona id_calendario_escolar -> validar contención
                PERFORM 1
                    FROM public.calendario_escolar c
                 WHERE c.id_calendario_escolar = NEW.id_calendario_escolar
                     AND c.semestre_inicio <= v_inicio
                     AND v_fin                         <= c.semestre_fin;

                IF NOT FOUND THEN
                        RAISE EXCEPTION
                            'El rango del evento [% - %] no está contenido en el calendario_escolar %',
                            v_inicio, v_fin, NEW.id_calendario_escolar
                            USING ERRCODE = '23514';
                END IF;
        END IF;

        RETURN NEW;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_default_id_calendario_escolar_evento ON public.evento;

CREATE TRIGGER trg_default_id_calendario_escolar_evento
BEFORE INSERT OR UPDATE ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_default_id_calendario_escolar_evento();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_default_id_calendario_escolar_evento()
IS 'Función disparada por trg_default_id_calendario_escolar_evento. Establece id_calendario_escolar por default o valida su contención';
-- trigger
COMMENT ON TRIGGER trg_default_id_calendario_escolar_evento ON public.evento
IS 'Establece id_calendario_escolar por default o valida su contención al insertar o actualizar un evento';

---------------------------------------------------------
/*
nombre: fun_validar_disponibilidad_equipamiento_evento
descripcion: Valida la disponibilidad de equipamiento al autorizar un evento.
        Si el evento se autoriza (estatus = 'autorizada'), verifica que el
        equipamiento solicitado esté disponible en las fechas y horarios del evento.
        Si no hay suficiente equipamiento, se lanza una excepción detallando los conflictos.

disparador: trg_validar_equipamiento_autorizacion
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_validar_disponibilidad_equipamiento_evento()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    conflictos TEXT;
BEGIN
    -- Solo validar cuando el estatus pase a 'autorizada'
    IF NEW.estatus IS DISTINCT FROM 'autorizada' THEN
        RETURN NEW;
    END IF;

    -- Si el evento no tiene equipamiento solicitado, no hay nada que validar
    IF NOT EXISTS (
        SELECT 1
        FROM public.eventoxequipamiento req
        WHERE req.id_evento = NEW.id_evento
    ) THEN
        RETURN NEW;
    END IF;

    WITH
    -- Cantidad requerida por este evento
    requerido AS (
        SELECT
            req.id_equipamiento,
            SUM(req.cantidad)::INTEGER AS qty_requerida
        FROM public.eventoxequipamiento req
        WHERE req.id_evento = NEW.id_evento
        GROUP BY req.id_equipamiento
    ),
    -- Cantidad ya ocupada por otros eventos AUTORIZADOS que se solapan
    ocupado AS (
        SELECT
            ee.id_equipamiento,
            SUM(ee.cantidad)::INTEGER AS qty_ocupada
        FROM public.eventoxequipamiento ee
        JOIN public.evento e
            ON e.id_evento = ee.id_evento
         AND e.estatus = 'autorizada'
         AND e.id_evento <> NEW.id_evento
         -- Solapamiento por FECHAS:
         AND NOT (NEW.fecha_fin < e.fecha_inicio OR NEW.fecha_inicio > e.fecha_fin)
         -- Solapamiento por HORARIO (si ambos tienen horarios):
         AND (
                     NEW.horario_inicio IS NULL OR NEW.horario_fin IS NULL
                OR e.horario_inicio    IS NULL OR e.horario_fin    IS NULL
                OR NOT (NEW.horario_fin <= e.horario_inicio OR NEW.horario_inicio >= e.horario_fin)
         )
        GROUP BY ee.id_equipamiento
    ),
    -- Comparar inventario con lo ocupado + lo requerido por el NEW evento
    verificacion AS (
        SELECT
            eq.id_equipamiento,
            eq.nombre AS equipamiento,
            eq.cantidad AS inventario_total,
            COALESCE(oc.qty_ocupada, 0) AS inventario_comprometido,
            r.qty_requerida,
            (eq.cantidad - COALESCE(oc.qty_ocupada, 0)) AS inventario_disponible,
            (eq.cantidad - COALESCE(oc.qty_ocupada, 0) - r.qty_requerida) AS inventario_restante
        FROM requerido r
        JOIN public.equipamiento eq
            ON eq.id_equipamiento = r.id_equipamiento
        LEFT JOIN ocupado oc
            ON oc.id_equipamiento = r.id_equipamiento
    )
    SELECT string_agg(
                     format(
                         '• %s (inventario=%s, ya comprometido=%s, requerido=%s, disponible=%s)',
                         equipamiento, inventario_total, inventario_comprometido, qty_requerida, inventario_disponible
                     ),
                     E'\n'
                 )
        INTO conflictos
    FROM verificacion
    WHERE inventario_restante < 0;

    IF conflictos IS NOT NULL THEN
        RAISE EXCEPTION
            USING
                MESSAGE = 'No es posible autorizar el evento: equipamiento insuficiente en la(s) fecha(s)/horario(s) solicitados',
                DETAIL    = conflictos,
                HINT        = 'Ajusta cantidades, elige otro horario/fecha, o libera equipamiento en eventos existentes';
    END IF;

    RETURN NEW;
END;
$$;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_validar_equipamiento_autorizacion ON public.evento;

CREATE TRIGGER trg_validar_equipamiento_autorizacion
BEFORE INSERT OR UPDATE OF estatus, fecha_inicio, fecha_fin, horario_inicio, horario_fin
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_validar_disponibilidad_equipamiento_evento();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_validar_disponibilidad_equipamiento_evento()
IS 'Función disparada por trg_validar_equipamiento_autorizacion. Valida la disponibilidad de equipamiento al autorizar un evento';
-- trigger
COMMENT ON TRIGGER trg_validar_equipamiento_autorizacion ON public.evento
IS 'Valida la disponibilidad de equipamiento al autorizar un evento';
---------------------------------------------------------
/*
nombre: fun_validar_ventana_registro_evento
descripcion: 
        Valida que la fecha de registro de un evento esté dentro de la ventana permitida.
        Reglas:
        (1) La fecha de registro no puede estar en la misma semana que la fecha de
                inicio del evento.
        (2) La fecha de registro debe ser como máximo el viernes a las 19:00 hrs
                de la semana anterior a la fecha de inicio del evento.
disparador: trg_validar_ventana_registro_evento
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_validar_ventana_registro_evento()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    -- inicio de semana de fecha_inicio (lunes 00:00)
    semana_inicio_ts    timestamp;
    -- semana anterior (lunes 00:00)
    semana_anterior_ts timestamp;
    -- deadline permitido: viernes 19:00 de la semana anterior
    deadline_ts timestamp;
    misma_semana boolean;
BEGIN
    -- Asegurar valores
    IF NEW.fecha_inicio IS NULL THEN
        RAISE EXCEPTION 'fecha_inicio no puede ser NULL para validar ventana de registro';
    END IF;

    -- Si no viene fecha_registro, el DEFAULT la pondrá; pero validamos de todos modos
    IF NEW.fecha_registro IS NULL THEN
        NEW.fecha_registro := CURRENT_TIMESTAMP;
    END IF;

    -- Normalizar: fecha_inicio es DATE; lo llevamos a timestamp al inicio del día
    semana_inicio_ts     := date_trunc('week', NEW.fecha_inicio::timestamp);
    semana_anterior_ts := semana_inicio_ts - INTERVAL '7 days';
    -- viernes = lunes + 4 días; 19:00 = 7 pm
    deadline_ts                := semana_anterior_ts + INTERVAL '4 days' + TIME '19:00';

    -- Regla (a): NO misma semana
    misma_semana := (date_trunc('week', NEW.fecha_registro) = semana_inicio_ts);
    IF misma_semana THEN
        RAISE EXCEPTION
            USING
                MESSAGE = 'No se puede registrar un evento cuya fecha de inicio esté en la misma semana que la fecha de registro',
                DETAIL    = format('fecha_registro=%s, fecha_inicio=%s; semana_inicio=%s',
                                                 to_char(NEW.fecha_registro, 'YYYY-MM-DD HH24:MI'),
                                                 to_char(NEW.fecha_inicio,     'YYYY-MM-DD'),
                                                 to_char(semana_inicio_ts,     'YYYY-MM-DD HH24:MI')),
                HINT        = 'Registra el evento al menos en la semana previa a su fecha de inicio';
    END IF;

    -- Regla (b): fecha_registro <= viernes 19:00 de la semana anterior a fecha_inicio
    IF NEW.fecha_registro > deadline_ts THEN
        RAISE EXCEPTION
            USING
                MESSAGE = 'La fecha de registro excede el límite permitido',
                DETAIL    = format('fecha_registro=%s, límite_permitido=%s (viernes 19:00 de la semana anterior)',
                                                 to_char(NEW.fecha_registro, 'YYYY-MM-DD HH24:MI'),
                                                 to_char(deadline_ts,                'YYYY-MM-DD HH24:MI')),
                HINT        = 'Anticípate: registra el evento antes del viernes 7:00 pm de la semana previa';
    END IF;

    RETURN NEW;
END;
$$;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_validar_ventana_registro_evento ON public.evento;

CREATE TRIGGER trg_validar_ventana_registro_evento
BEFORE INSERT OR UPDATE OF fecha_inicio, fecha_registro
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_validar_ventana_registro_evento();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_validar_ventana_registro_evento()
IS 'Función disparada por trg_validar_ventana_registro_evento. Valida que la fecha de registro de un evento esté dentro de la ventana permitida';
-- trigger
COMMENT ON TRIGGER trg_validar_ventana_registro_evento ON public.evento
IS 'Trigger que valida la ventana de registro de un evento antes de insertar o actualizar';
---------------------------------------------------------
/*
nombre: fun_forzar_mayusculas_rfc
descripcion: 
    Función que fuerza a que el RFC se almacene en mayúsculas.
disparador: trg_evento_rfc_upper
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_forzar_mayusculas_rfc()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rfc IS NOT NULL THEN
        NEW.rfc := UPPER(NEW.rfc);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_evento_rfc_upper ON public.usuario;

CREATE TRIGGER trg_evento_rfc_upper
BEFORE INSERT OR UPDATE ON public.usuario
FOR EACH ROW
EXECUTE FUNCTION fun_forzar_mayusculas_rfc();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_forzar_mayusculas_rfc() 
IS 'Función que fuerza a que el RFC se almacene en mayúsculas';
-- trigger
COMMENT ON TRIGGER trg_evento_rfc_upper ON public.usuario
IS 'Fuerza a que el RFC se almacene en mayúsculas';
---------------------------------------------------------
/*
nombre: fun_verificar_evento_no_en_periodo
descripcion: 
    Función que verifica que un evento no se solape con periodos existentes en el calendario escolar.
disparador: trg_evento_no_en_periodo
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_verificar_evento_no_en_periodo()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    conflicto RECORD;
BEGIN
    -- Por seguridad (aunque ya hay CHECKs)
    IF NEW.fecha_inicio IS NULL OR NEW.fecha_fin IS NULL THEN
        RETURN NEW;
    END IF;

    -- Verifica solapamiento de rangos de fecha con cualquier periodo del mismo calendario
    SELECT p.id_periodo, p.fecha_inicio, p.fecha_fin, tp.nombre
      INTO conflicto
      FROM public.periodo p
      JOIN public.tipo_periodo tp USING (id_tipo_periodo)
     WHERE p.id_calendario_escolar = NEW.id_calendario_escolar
       AND daterange(p.fecha_inicio, p.fecha_fin, '[]')
           && daterange(NEW.fecha_inicio, NEW.fecha_fin, '[]')
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'El evento (%–%) se traslapa con un período "%": %–% (id=%) del calendario escolar %',
            NEW.fecha_inicio, NEW.fecha_fin,
            conflicto.nombre, conflicto.fecha_inicio, conflicto.fecha_fin,
            conflicto.id_periodo, NEW.id_calendario_escolar
        USING ERRCODE = 'check_violation',
              HINT = 'No se permiten eventos durante vacaciones, días inhábiles, exámenes u otros periodos del calendario escolar.';
    END IF;

    RETURN NEW;
END;
$$;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_evento_no_en_periodo ON public.evento;

CREATE TRIGGER trg_evento_no_en_periodo
BEFORE INSERT OR UPDATE OF fecha_inicio, fecha_fin, id_calendario_escolar
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_verificar_evento_no_en_periodo();

---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_verificar_evento_no_en_periodo()
IS 'Función que verifica que un evento no se solape con periodos existentes en el calendario escolar.';
-- trigger
COMMENT ON TRIGGER trg_evento_no_en_periodo ON public.evento
IS 'Verifica que un evento no se solape con periodos existentes en el calendario escolar.';

---------------------------------------------------------
/*
nombre: fun_periodo_dentro_del_calendario
descripcion: 
    Función que valida que un periodo esté completamente dentro del rango de un semestre académico.
    disparador: trg_periodo_dentro_del_calendario
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_periodo_dentro_del_calendario()
RETURNS TRIGGER AS $$
DECLARE
    v_semestre_inicio date;
    v_semestre_fin        date;
BEGIN
    -- Validaciones básicas del propio periodo
    IF NEW.fecha_inicio IS NULL OR NEW.fecha_fin IS NULL THEN
        RAISE EXCEPTION 'fecha_inicio y fecha_fin no pueden ser NULL en "periodo".';
    END IF;

    IF NEW.fecha_inicio > NEW.fecha_fin THEN
        RAISE EXCEPTION 'fecha_inicio (%) no puede ser mayor que fecha_fin (%).',
            NEW.fecha_inicio, NEW.fecha_fin;
    END IF;

    -- Traer el rango del calendario_escolar asociado
    SELECT ce.semestre_inicio, ce.semestre_fin
        INTO v_semestre_inicio, v_semestre_fin
    FROM public.calendario_escolar ce
    WHERE ce.id_calendario_escolar = NEW.id_calendario_escolar;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe calendario_escolar con id % (referenciado por periodo).',
            NEW.id_calendario_escolar;
    END IF;

    -- Verificar inclusión del periodo dentro del semestre (inclusive)
    IF NEW.fecha_inicio < v_semestre_inicio OR NEW.fecha_fin > v_semestre_fin THEN
        RAISE EXCEPTION
            'El periodo [% - %] debe estar completamente dentro del semestre [% - %].',
            NEW.fecha_inicio, NEW.fecha_fin, v_semestre_inicio, v_semestre_fin;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_periodo_dentro_del_calendario ON public.periodo;

CREATE TRIGGER trg_periodo_dentro_del_calendario
BEFORE INSERT OR UPDATE ON public.periodo
FOR EACH ROW
EXECUTE FUNCTION public.fun_periodo_dentro_del_calendario();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_periodo_dentro_del_calendario() 
IS 'Función que valida que un periodo esté completamente dentro del rango de un semestre académico.';
-- trigger
COMMENT ON TRIGGER trg_periodo_dentro_del_calendario ON public.periodo 
IS 'Valida que el periodo esté completamente dentro del rango de un semestre académico.';
---------------------------------------------------------
/*
    nombre: fun_verificar_conflictos_evento
    descripcion: 
        Función que verifica si un evento que se intenta autorizar
        genera conflictos de traslape con otros eventos autorizados
        en recintos o ponentes.
    disparador: trg_evento_evitar_autorizados_traslapados
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
-- 1) Función de validación: levanta excepción si hay conflicto
CREATE OR REPLACE FUNCTION public.fun_verificar_conflictos_evento(
        p_id_evento            INTEGER,
        p_fecha_inicio     DATE,
        p_fecha_fin            DATE,
        p_hora_inicio        TIME,
        p_hora_fin             TIME
) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
        v_conf_rec RECORD;
        v_conf_pon RECORD;
BEGIN
        --------------------------------------------------------------------------
        -- Reglas de traslape:
        --    Hay traslape de fechas si:    NOT (nuevo.fin < otro.inicio OR nuevo.inicio > otro.fin)
        --    Hay traslape de horas    si:    NOT (nuevo.fin <= otro.inicio OR nuevo.inicio >= otro.fin)
        --------------------------------------------------------------------------

        -- Conflicto por RECINTO (mismo id_recinto)
        SELECT e2.id_evento AS id_evento_conflictivo, r2.id_recinto AS id_recinto_conflictivo
        INTO v_conf_rec
        FROM reservacion r1                                                    -- recintos del evento que quiero autorizar
        JOIN reservacion r2
            ON r2.id_recinto = r1.id_recinto                    -- mismo recinto
        JOIN evento e2
            ON e2.id_evento = r2.id_evento
        WHERE r1.id_evento = p_id_evento
            AND e2.id_evento <> p_id_evento
            AND e2.estatus = 'autorizado'
            -- traslape de rangos de fecha
            AND NOT (p_fecha_fin < e2.fecha_inicio OR p_fecha_inicio > e2.fecha_fin)
            -- traslape de rangos de horario
            AND NOT (p_hora_fin    <= e2.horario_inicio OR p_hora_inicio >= e2.horario_fin)
        LIMIT 1;

        IF FOUND THEN
                RAISE EXCEPTION
                    'Conflicto de recinto: el recinto % ya tiene un evento autorizado (%) que traslapa en fecha/horario.',
                    v_conf_rec.id_recinto_conflictivo, v_conf_rec.id_evento_conflictivo
                USING ERRCODE = 'check_violation';
        END IF;

        -- Conflicto por PONENTE (mismo id_ponente)
        SELECT e2.id_evento AS id_evento_conflictivo, p2.id_ponente AS id_ponente_conflictivo
        INTO v_conf_pon
        FROM participacion p1                                                -- ponentes del evento que quiero autorizar
        JOIN participacion p2
            ON p2.id_ponente = p1.id_ponente                    -- mismo ponente
        JOIN evento e2
            ON e2.id_evento = p2.id_evento
        WHERE p1.id_evento = p_id_evento
            AND e2.id_evento <> p_id_evento
            AND e2.estatus = 'autorizado'
            -- traslape de rangos de fecha
            AND NOT (p_fecha_fin < e2.fecha_inicio OR p_fecha_inicio > e2.fecha_fin)
            -- traslape de rangos de horario
            AND NOT (p_hora_fin    <= e2.horario_inicio OR p_hora_inicio >= e2.horario_fin)
        LIMIT 1;

        IF FOUND THEN
                RAISE EXCEPTION
                    'Conflicto de ponente: el ponente % ya tiene un evento autorizado (%) que traslapa en fecha/horario.',
                    v_conf_pon.id_ponente_conflictivo, v_conf_pon.id_evento_conflictivo
                USING ERRCODE = 'check_violation';
        END IF;

END;
$$;

-- 2) Trigger: se ejecuta al intentar autorizar (o cambiar fechas/horas de) un evento
CREATE OR REPLACE FUNCTION public.trg_evento_evitar_autorizados_traslapados()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
        -- Solo valida cuando el nuevo estatus sea 'autorizado'
        IF NEW.estatus = 'autorizado' THEN
                PERFORM public.fun_verificar_conflictos_evento(
                        NEW.id_evento,
                        NEW.fecha_inicio,
                        NEW.fecha_fin,
                        NEW.horario_inicio,
                        NEW.horario_fin
                );
        END IF;

        RETURN NEW;
END;
$$;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_evento_evitar_autorizados_traslapados ON public.evento;

CREATE TRIGGER trg_evento_evitar_autorizados_traslapados
BEFORE INSERT OR UPDATE OF estatus, fecha_inicio, fecha_fin, horario_inicio, horario_fin
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.trg_evento_evitar_autorizados_traslapados();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.trg_evento_evitar_autorizados_traslapados()
IS 'Función disparada por trg_evento_evitar_autorizados_traslapados. Verifica si un evento que se intenta autorizar genera conflictos de traslape con otros eventos autorizados en recintos o ponentes.';
-- trigger
COMMENT ON TRIGGER trg_evento_evitar_autorizados_traslapados ON public.evento
IS 'Disparador que evita la autorización de eventos que se traslapan con otros eventos autorizados en recintos o ponentes.';

---------------------------------------------------------
/*
    nombre: fun_verificar_solapamiento_semestres
    descripcion: 
		Función que verifica que no haya solapamiento entre los semestres
		al insertar o actualizar un calendario escolar.
    disparador: trg_verificar_solapamiento_semestres
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_verificar_solapamiento_semestres()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si existe solapamiento con otro registro
    IF EXISTS (
        SELECT 1
        FROM calendario_escolar c
        WHERE 
            c.id_calendario_escolar <> COALESCE(NEW.id_calendario_escolar, -1)
            AND (
                (NEW.semestre_inicio, NEW.semestre_fin) OVERLAPS (c.semestre_inicio, c.semestre_fin)
            )
    ) THEN
        RAISE EXCEPTION 'El rango de fechas del semestre (% - %) se solapa con otro semestre existente.',
            NEW.semestre_inicio, NEW.semestre_fin
            USING ERRCODE = 'check_violation';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_verificar_solapamiento_semestres ON calendario_escolar;

CREATE TRIGGER trg_verificar_solapamiento_semestres
BEFORE INSERT OR UPDATE
ON calendario_escolar
FOR EACH ROW
EXECUTE FUNCTION fun_verificar_solapamiento_semestres();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION fun_verificar_solapamiento_semestres()
IS 'Función que verifica que no haya solapamiento entre los semestres
	al insertar o actualizar un calendario escolar.';
---------------------------------------------------------
-- trigger
---------------------------------------------------------
COMMENT ON TRIGGER trg_verificar_solapamiento_semestres ON public.calendario_escolar
IS 'Disparador que verifica que no haya solapamiento entre los semestres
	al insertar o actualizar un calendario escolar.';

---------------------------------------------------------
/*
    nombre: fun_validar_evento_en_mega_evento
    descripcion: 
		Función que valida que un evento hijo esté correctamente relacionado con su mega_evento.
    disparador: trg_validar_evento_en_mega_evento
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_validar_evento_en_mega_evento()
RETURNS TRIGGER AS $$
DECLARE
    v_padre public.evento%ROWTYPE;
BEGIN
    -- Si no tiene mega evento, no hay nada que validar
    IF NEW.id_mega_evento IS NULL THEN
        RETURN NEW;
    END IF;

    -- Evitar auto-referencia
    IF NEW.id_mega_evento = NEW.id_evento THEN
        RAISE EXCEPTION 'Un evento no puede referenciarse a sí mismo como mega_evento.'
            USING ERRCODE = 'check_violation';
    END IF;

    -- Cargar el mega evento (padre)
    SELECT *
      INTO v_padre
      FROM public.evento
     WHERE id_evento = NEW.id_mega_evento;

    -- Por FK no debería faltar, pero por robustez:
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El mega_evento con id % no existe.', NEW.id_mega_evento
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    -- Validar que el padre esté marcado como mega_evento
    IF v_padre.mega_evento IS DISTINCT FROM TRUE THEN
        RAISE EXCEPTION 'El evento padre (id=%) no está marcado como mega_evento.', v_padre.id_evento
            USING ERRCODE = 'check_violation';
    END IF;

    -- Un evento hijo no puede ser a la vez mega_evento
    IF NEW.mega_evento IS TRUE THEN
        RAISE EXCEPTION 'Un evento con id_mega_evento no puede estar marcado como mega_evento.'
            USING ERRCODE = 'check_violation';
    END IF;

    -- Deben pertenecer al mismo calendario escolar
    IF NEW.id_calendario_escolar <> v_padre.id_calendario_escolar THEN
        RAISE EXCEPTION 'El evento (cal=%) y su mega_evento (cal=%) deben pertenecer al mismo calendario_escolar.',
            NEW.id_calendario_escolar, v_padre.id_calendario_escolar
            USING ERRCODE = 'check_violation';
    END IF;

    -- Validar rango de fechas dentro del mega_evento
    IF NEW.fecha_inicio < v_padre.fecha_inicio OR NEW.fecha_fin > v_padre.fecha_fin THEN
        RAISE EXCEPTION 'Las fechas del evento (% - %) deben estar dentro del mega_evento (% - %).',
            NEW.fecha_inicio, NEW.fecha_fin, v_padre.fecha_inicio, v_padre.fecha_fin
            USING ERRCODE = 'check_violation';
    END IF;

    -- Validar rango de horarios dentro del mega_evento (por día)
    IF NEW.horario_inicio < v_padre.horario_inicio OR NEW.horario_fin > v_padre.horario_fin THEN
        RAISE EXCEPTION 'Los horarios del evento (% - %) deben estar dentro del mega_evento (% - %).',
            NEW.horario_inicio, NEW.horario_fin, v_padre.horario_inicio, v_padre.horario_fin
            USING ERRCODE = 'check_violation';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_validar_evento_en_mega_evento ON public.evento;

CREATE TRIGGER trg_validar_evento_en_mega_evento
BEFORE INSERT OR UPDATE
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION fun_validar_evento_en_mega_evento();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION fun_validar_evento_en_mega_evento()
IS 'Función que valida que un evento hijo esté correctamente relacionado con su mega_evento.';
---------------------------------------------------------
-- trigger
---------------------------------------------------------
COMMENT ON TRIGGER trg_validar_evento_en_mega_evento ON public.evento
IS 'Disparador que valida que un evento hijo esté correctamente relacionado con su mega_evento.';

---------------------------------------------------------
/*
    nombre: fun_validar_puesto_unico_en_usuario()
    descripcion:
        Verifica, en INSERT o UPDATE de public.usuario (cuando se inserta o cambia id_puesto),
        que si el puesto asociado tiene unico = true no exista ningún otro usuario con ese mismo
        id_puesto. Para evitar condiciones de carrera, bloquea la fila del puesto con
        SELECT ... FOR UPDATE. En caso de conflicto, lanza una excepción 23505 (unique_violation)
        con una sugerencia de resolución.
    disparador: trg_validar_puesto_unico_en_usuario
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_validar_puesto_unico_en_usuario()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_unico              boolean;
    v_puesto_nombre      text;
    v_conflict_user_id   smallint;
    v_conflict_user_name text;
BEGIN
    -- ¿El puesto nuevo es único?
    SELECT p.unico, p.nombre
      INTO v_unico, v_puesto_nombre
      FROM public.puesto p
     WHERE p.id_puesto = NEW.id_puesto;

    IF v_unico IS TRUE THEN
        -- Bloqueo para evitar carreras
        PERFORM 1
          FROM public.puesto p
         WHERE p.id_puesto = NEW.id_puesto
         FOR UPDATE;

        -- ¿Ya hay otro usuario con ese puesto?
        SELECT u.id_usuario,
               CONCAT_WS(' ', u.nombre, u.apellido_paterno, u.apellido_materno)
          INTO v_conflict_user_id, v_conflict_user_name
          FROM public.usuario u
         WHERE u.id_puesto = NEW.id_puesto
           AND u.id_usuario IS DISTINCT FROM NEW.id_usuario
         LIMIT 1;

        IF v_conflict_user_id IS NOT NULL THEN
            RAISE EXCEPTION
                'El puesto "%" es único y ya está asignado al usuario % (id=%).',
                v_puesto_nombre, v_conflict_user_name, v_conflict_user_id
            USING ERRCODE = '23505',
                  HINT = 'Desasigna el puesto del otro usuario o establece unico=false en el puesto si aplica.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_validar_puesto_unico_en_usuario ON public.usuario;

CREATE TRIGGER trg_validar_puesto_unico_en_usuario
BEFORE INSERT OR UPDATE OF id_puesto
ON public.usuario
FOR EACH ROW
EXECUTE FUNCTION public.fun_validar_puesto_unico_en_usuario();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION fun_validar_puesto_unico_en_usuario()
IS 'Valida en INSERT/UPDATE de public.usuario que, si el puesto referenciado tiene unico=true, no exista otro usuario con el mismo id_puesto. Bloquea la fila del puesto para evitar carreras y lanza 23505 (unique_violation) en caso de conflicto.';
---------------------------------------------------------
-- trigger
---------------------------------------------------------
COMMENT ON TRIGGER trg_validar_puesto_unico_en_usuario ON public.usuario
IS 'Disparador BEFORE INSERT/UPDATE OF id_puesto en public.usuario que ejecuta fun_validar_puesto_unico_en_usuario() para asegurar la unicidad de puestos marcados como unico=true.';
---------------------------------------------------------
/*
    nombre: fun_validar_puesto_unico_al_cambiar_bandera()
    descripcion:
        Valida en public.puesto, al INSERT o al UPDATE de la columna unico, que al
        establecer unico = true el puesto no esté asignado a más de un usuario en
        public.usuario. Bloquea la fila del puesto con SELECT ... FOR UPDATE para
        evitar condiciones de carrera. Si hay más de un usuario asignado, cancela con
        excepción 23514 (check_violation) e indica cómo resolverlo.
    disparador: trg_validar_puesto_unico_al_cambiar_bandera
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_validar_puesto_unico_al_cambiar_bandera()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_count int;
BEGIN
    -- Solo aplica si estamos activando la unicidad
    IF NEW.unico IS TRUE AND (TG_OP = 'INSERT' OR OLD.unico IS DISTINCT FROM NEW.unico) THEN
        -- Bloqueamos la fila del puesto para evitar carreras
        PERFORM 1
        FROM public.puesto p
        WHERE p.id_puesto = NEW.id_puesto
        FOR UPDATE;

        -- Contamos usuarios que ya lo tienen
        SELECT COUNT(*)
        INTO v_count
        FROM public.usuario u
        WHERE u.id_puesto = NEW.id_puesto;

        IF v_count > 1 THEN
            RAISE EXCEPTION
                'No se puede establecer unico=true en el puesto (%) porque ya está asignado a % usuarios.',
                NEW.id_puesto, v_count
            USING ERRCODE = '23514', -- check_violation
                  HINT = 'Desasigna el puesto de los usuarios sobrantes hasta dejar máximo 1, y vuelve a intentarlo.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$;
---------------------------------------------------------
-- trigger
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_validar_puesto_unico_al_cambiar_bandera ON public.puesto;

CREATE TRIGGER trg_validar_puesto_unico_al_cambiar_bandera
BEFORE INSERT OR UPDATE OF unico
ON public.puesto
FOR EACH ROW
EXECUTE FUNCTION public.fun_validar_puesto_unico_al_cambiar_bandera();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION fun_validar_puesto_unico_al_cambiar_bandera()
IS 'Valida en INSERT/UPDATE de public.puesto que, al activar unico=true, el puesto no esté asignado a más de un usuario. Bloquea la fila del puesto y lanza 23514 (check_violation) si hay más de un asignado.';
---------------------------------------------------------
-- trigger
---------------------------------------------------------
COMMENT ON TRIGGER trg_validar_puesto_unico_al_cambiar_bandera ON public.puesto
IS 'Disparador BEFORE INSERT/UPDATE OF unico en public.puesto que ejecuta fun_validar_puesto_unico_al_cambiar_bandera() para impedir activar unico=true si el puesto ya está asignado a más de un usuario.';
---------------------------------------------------------
/*
    nombre: fun_estatus_por_fecha
    descripcion:
        Determina el estatus correcto de un evento con base en su fecha_inicio.
        Reglas:
          - Si p_estatus_actual = 'cancelado' ⇒ se respeta y no se modifica.
          - Si p_fecha_inicio <= CURRENT_DATE ⇒ estatus 'realizado'.
          - En cualquier otro caso ⇒ se conserva p_estatus_actual.
        Esta lógica es usada por:
          a) Un trigger BEFORE INSERT/UPDATE para garantizar consistencia inmediata
             en cada escritura sobre public.evento.
          b) Un job periódico para “ponerse al día” con filas que no han sido
             modificadas pero cuya fecha ya excedió.

    disparador: trg_actualizar_estatus_evento
    job: job_actualizar_eventos_realizados()
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_estatus_por_fecha(
    p_fecha_inicio DATE,
    p_estatus_actual VARCHAR
)
RETURNS VARCHAR AS $$
BEGIN
    -- Si el evento está cancelado, no se modifica
    IF p_estatus_actual = 'cancelado' THEN
        RETURN p_estatus_actual;
    END IF;

    -- Si la fecha de inicio ya pasó o es hoy, cambia a 'realizado'
    IF p_fecha_inicio <= CURRENT_DATE THEN
        RETURN 'realizado';
    END IF;

    -- En cualquier otro caso, deja el estatus actual
    RETURN p_estatus_actual;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------
-- trigger (INSERT & UPDATE)
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trg_evento_set_estatus()
RETURNS TRIGGER AS $$
BEGIN
    NEW.estatus := public.fun_estatus_por_fecha(NEW.fecha_inicio, NEW.estatus);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_actualizar_estatus_evento ON public.evento;

CREATE TRIGGER trg_actualizar_estatus_evento
BEFORE INSERT OR UPDATE ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.trg_evento_set_estatus();

---------------------------------------------------------
-- job (JOB DIARIO)
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.job_actualizar_eventos_realizados()
RETURNS void AS $$
BEGIN
    UPDATE public.evento e
    SET estatus = public.fun_estatus_por_fecha(e.fecha_inicio, e.estatus)
    WHERE e.estatus <> public.fun_estatus_por_fecha(e.fecha_inicio, e.estatus);
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION public.fun_estatus_por_fecha(date, character varying)
IS 'Retorna el estatus correcto para un evento: respeta "cancelado"; si fecha_inicio <= CURRENT_DATE ⇒ "realizado"; en caso contrario conserva el estatus actual. Usada por trigger y job.';

---------------------------------------------------------
-- trigger (INSERT & UPDATE)
---------------------------------------------------------
COMMENT ON TRIGGER trg_actualizar_estatus_evento ON public.evento
IS 'Trigger BEFORE INSERT/UPDATE que ajusta NEW.estatus usando fun_estatus_por_fecha para mantener consistencia inmediata.';

---------------------------------------------------------
-- job (JOB DIARIO)
---------------------------------------------------------
COMMENT ON FUNCTION public.job_actualizar_eventos_realizados()
IS 'Job que sincroniza estatus de eventos ya almacenados: aplica fun_estatus_por_fecha por lotes para poner "realizado" cuando corresponda y nunca pisa "cancelado".';
---------------------------------------------------------
/*
    nombre: fun_actualizar_ultima_modificacion
    descripcion:
        Función genérica que actualiza el campo ultima_modificacion con la marca de tiempo actual
        cada vez que se modifica un registro en tablas que la implementen mediante un trigger.
        Aplicada actualmente a:
            - public.inventario_recinto
            - public.inventario_area
        Regla:
          - En cada operación UPDATE, el campo ultima_modificacion se actualiza a CURRENT_TIMESTAMP.
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_actualizar_ultima_modificacion()
RETURNS TRIGGER AS $$
BEGIN
    -- Actualiza el campo de última modificación a la hora actual del servidor
    NEW.ultima_modificacion := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------
-- trigger (UPDATE) - inventario_recinto
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_actualizar_ultima_modificacion_recinto ON public.inventario_recinto;

CREATE TRIGGER trg_actualizar_ultima_modificacion_recinto
BEFORE UPDATE ON public.inventario_recinto
FOR EACH ROW
EXECUTE FUNCTION public.fun_actualizar_ultima_modificacion();

---------------------------------------------------------
-- trigger (UPDATE) - inventario_area
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_actualizar_ultima_modificacion_area ON public.inventario_area;

CREATE TRIGGER trg_actualizar_ultima_modificacion_area
BEFORE UPDATE ON public.inventario_area
FOR EACH ROW
EXECUTE FUNCTION public.fun_actualizar_ultima_modificacion();

---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION public.fun_actualizar_ultima_modificacion()
IS 'Actualiza automáticamente el campo ultima_modificacion con CURRENT_TIMESTAMP antes de cualquier UPDATE. Reutilizable por múltiples tablas.';

---------------------------------------------------------
-- trigger (UPDATE) - inventario_recinto
---------------------------------------------------------
COMMENT ON TRIGGER trg_actualizar_ultima_modificacion_recinto ON public.inventario_recinto
IS 'Trigger BEFORE UPDATE que actualiza ultima_modificacion al timestamp actual en la tabla inventario_recinto.';

---------------------------------------------------------
-- trigger (UPDATE) - inventario_area
---------------------------------------------------------
COMMENT ON TRIGGER trg_actualizar_ultima_modificacion_area ON public.inventario_area
IS 'Trigger BEFORE UPDATE que actualiza ultima_modificacion al timestamp actual en la tabla inventario_area.';

---------------------------------------------------------
/*
    nombre: fun_generar_croquis_google_maps
    descripcion:
        Genera y asigna automáticamente el enlace de Google Maps al campo 'croquis' de public.recinto
        usando las coordenadas (latitud, longitud). Optimizado para:
          - INSERT: siempre genera el enlace.
          - UPDATE: solo re-genera el enlace si cambian latitud o longitud.

        Formato del link:
          https://www.google.com/maps/search/?api=1&query=<latitud>,<longitud>

        Entradas:
          - NEW.latitud  (NUMERIC(9,6))
          - NEW.longitud (NUMERIC(9,6))

        Salida:
          - NEW con 'croquis' actualizado si corresponde.

        Reglas/garantías:
          - No altera 'croquis' en UPDATE si no cambian las coordenadas.
          - Los CHECK de la tabla validan rangos de latitud/longitud.
          - Satisface NOT NULL y no-vacío de 'croquis' en INSERT.

        Consideraciones:
          - CURRENT locale: se usa TO_CHAR con formato fijo (6 decimales) sin separadores de miles.
          - Idempotente ante updates sin cambios de coordenadas.
*/

---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_generar_croquis_google_maps()
RETURNS TRIGGER AS $$
BEGIN
    -- En INSERT siempre generamos el enlace
    IF TG_OP = 'INSERT' THEN
        NEW.croquis := 'https://www.google.com/maps/search/?api=1&query='
                       || TRIM(TO_CHAR(NEW.latitud,  'FM999999990.999999'))
                       || ','
                       || TRIM(TO_CHAR(NEW.longitud, 'FM999999990.999999'));
        RETURN NEW;
    END IF;

    -- En UPDATE solo si cambian latitud o longitud
    IF NEW.latitud  IS DISTINCT FROM OLD.latitud
       OR NEW.longitud IS DISTINCT FROM OLD.longitud THEN
        NEW.croquis := 'https://www.google.com/maps/search/?api=1&query='
                       || TRIM(TO_CHAR(NEW.latitud,  'FM999999990.999999'))
                       || ','
                       || TRIM(TO_CHAR(NEW.longitud, 'FM999999990.999999'));
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------
-- trigger (INSERT & UPDATE)
---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_generar_croquis_google_maps ON public.recinto;

CREATE TRIGGER trg_generar_croquis_google_maps
BEFORE INSERT OR UPDATE ON public.recinto
FOR EACH ROW
EXECUTE FUNCTION public.fun_generar_croquis_google_maps();

---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
---------------------------------------------------------
COMMENT ON FUNCTION public.fun_generar_croquis_google_maps()
IS 'Genera automáticamente el enlace de Google Maps en "croquis" (INSERT) y lo actualiza solo si cambian latitud/longitud (UPDATE). Usa formato search/?api=1&query=lat,long con 6 decimales.';

---------------------------------------------------------
-- trigger (INSERT & UPDATE)
---------------------------------------------------------
COMMENT ON TRIGGER trg_generar_croquis_google_maps ON public.recinto
IS 'BEFORE INSERT/UPDATE: construye "croquis" con Google Maps. En UPDATE solo si cambian latitud o longitud.';

---------------------------------------------------------
COMMIT;
