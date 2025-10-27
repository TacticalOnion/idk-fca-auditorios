SET client_encoding to 'UTF8';
BEGIN;

--------------------------------------------------------
/*
nombre: fun_set_default_fecha_fin
descripcion: 
        Establece fecha_fin igual a fecha_inicio si no se proporciona fecha_fin 
        al insertar un nuevo evento.
disparador: trg_set_default_fecha_fin
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_set_default_fecha_fin()
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
DROP TRIGGER IF EXISTS trg_set_default_fecha_fin ON public.evento;

CREATE TRIGGER trg_set_default_fecha_fin
BEFORE INSERT ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_set_default_fecha_fin();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_set_default_fecha_fin()
IS 'Función disparada por trg_set_default_fecha_fin. Establece fecha_fin igual a fecha_inicio por default';
-- trigger
COMMENT ON TRIGGER trg_set_default_fecha_fin ON public.evento
IS 'Establece fecha_fin igual a fecha_inicio si no se proporciona fecha_fin al insertar un nuevo evento'; 
---------------------------------------------------------
/*
nombre: fun_set_default_id_calendario_escolar_evento
descripcion: 
        Establece id_calendario_escolar por default el valor del id del
        ultimo calendario_escolar que contenga el rango del evento. Si el usuario
        proporciona un id_calendario_escolar, valida que el rango del evento
disparador: trg_set_default_id_cal_evento
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_set_default_id_calendario_escolar_evento()
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
DROP TRIGGER IF EXISTS trg_set_default_id_cal_evento ON public.evento;

CREATE TRIGGER trg_set_default_id_cal_evento
BEFORE INSERT OR UPDATE ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.fun_set_default_id_calendario_escolar_evento();
---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_set_default_id_calendario_escolar_evento()
IS 'Función disparada por trg_set_default_id_cal_evento. Establece id_calendario_escolar por default o valida su contención';
-- trigger
COMMENT ON TRIGGER trg_set_default_id_cal_evento ON public.evento
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
nombre: fun_check_evento_no_en_periodo
descripcion: 
    Función que verifica que un evento no se solape con periodos existentes en el calendario escolar.
disparador: trg_evento_no_en_periodo
*/
---------------------------------------------------------
-- funcion
---------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fun_check_evento_no_en_periodo()
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
EXECUTE FUNCTION public.fun_check_evento_no_en_periodo();

---------------------------------------------------------
-- documentacion
---------------------------------------------------------
-- funcion
COMMENT ON FUNCTION public.fun_check_evento_no_en_periodo()
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
    disparador: trg_fun_verificar_solapamiento_semestres
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
DROP TRIGGER IF EXISTS trg_fun_verificar_solapamiento_semestres ON calendario_escolar;

CREATE TRIGGER trg_fun_verificar_solapamiento_semestres
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
COMMENT ON TRIGGER trg_fun_verificar_solapamiento_semestres ON public.calendario_escolar
IS 'Disparador que verifica que no haya solapamiento entre los semestres
	al insertar o actualizar un calendario escolar.';

---------------------------------------------------------
/*
    nombre: fun_validar_evento_en_mega_evento
    descripcion: 
		Función que valida que un evento hijo esté correctamente relacionado con su mega_evento.
    disparador: trg_fun_validar_evento_en_mega_evento
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
DROP TRIGGER IF EXISTS trg_fun_validar_evento_en_mega_evento ON public.evento;

CREATE TRIGGER trg_fun_validar_evento_en_mega_evento
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
COMMENT ON TRIGGER trg_fun_validar_evento_en_mega_evento ON public.evento
IS 'Disparador que valida que un evento hijo esté correctamente relacionado con su mega_evento.';

COMMIT;