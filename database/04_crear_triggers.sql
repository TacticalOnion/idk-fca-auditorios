-- Función para verificar que una participación no esté asociada a un megaevento
CREATE OR REPLACE FUNCTION verificar_evento_no_mega()
RETURNS trigger AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM evento e
    WHERE e.id_evento = NEW.id_evento
      AND e.mega_evento = TRUE
  ) THEN
    RAISE EXCEPTION 'No se puede asignar un id_evento que pertenece a un megaevento (mega_evento = TRUE)';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_evento_no_mega
BEFORE INSERT OR UPDATE ON public.participacion
FOR EACH ROW
EXECUTE FUNCTION verificar_evento_no_mega();

-- Función para verificar que la fecha de inicio del evento no esté dentro de la misma semana que la fecha de solicitud de la reservación
CREATE OR REPLACE FUNCTION verificar_evento_fuera_semana_actual()
RETURNS TRIGGER AS $$
DECLARE
    fecha_inicio_evento DATE;
    inicio_semana DATE;
    fin_semana DATE;
BEGIN
    -- Obtener la fecha_inicio del evento asociado
    SELECT fecha_inicio INTO fecha_inicio_evento
    FROM public.evento
    WHERE id_evento = NEW.id_evento;

    -- Calcular inicio y fin de la semana de la fecha_solicitud
    inicio_semana := date_trunc('week', NEW.fecha_solicitud)::date;
    fin_semana := inicio_semana + interval '1 week' - interval '1 day';

    -- Verificar que el evento no inicie dentro de la misma semana
    IF fecha_inicio_evento BETWEEN inicio_semana AND fin_semana THEN
        RAISE EXCEPTION 'No se puede reservar un evento cuya fecha de inicio (%)
                         se encuentra dentro de la misma semana que la fecha de solicitud (%)',
                         fecha_inicio_evento, NEW.fecha_solicitud;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_evento_fuera_semana
BEFORE INSERT OR UPDATE ON public.reservacion
FOR EACH ROW
EXECUTE FUNCTION verificar_evento_fuera_semana_actual();

-- Función para validar el estatus del evento según su fecha de inicio
CREATE OR REPLACE FUNCTION validar_estatus_evento_por_fecha()
RETURNS TRIGGER AS $$
DECLARE
    nombre_estatus TEXT;
BEGIN
    -- Validar que el id_estatus exista y obtener su nombre
    SELECT e.nombre INTO nombre_estatus
    FROM public.estatus e
    WHERE e.id_estatus = NEW.id_estatus;

    IF nombre_estatus IS NULL THEN
        RAISE EXCEPTION 'id_estatus % no existe en public.estatus', NEW.id_estatus;
    END IF;

    -- Normalizar comparación a nivel de fecha (sin hora)
    IF NEW.fecha_inicio::date >= CURRENT_DATE THEN
        -- Evento no pasado: solo 'Autorizada' o 'Pendiente'
        IF nombre_estatus NOT IN ('Autorizada', 'Pendiente') THEN
            RAISE EXCEPTION
                'Para eventos no pasados (fecha_inicio=%), el estatus debe ser Autorizada o Pendiente. Recibido: %',
                NEW.fecha_inicio::date, nombre_estatus;
        END IF;
    ELSE
        -- Evento ya pasado: solo 'Cancelada' o 'Realizada'
        IF nombre_estatus NOT IN ('Cancelada', 'Realizada') THEN
            RAISE EXCEPTION
                'Para eventos ya pasados (fecha_inicio=%), el estatus debe ser Cancelada o Realizada. Recibido: %',
                NEW.fecha_inicio::date, nombre_estatus;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_estatus_evento_por_fecha
BEFORE INSERT OR UPDATE ON public.evento
FOR EACH ROW
EXECUTE FUNCTION validar_estatus_evento_por_fecha();

-- Función para verificar que una reservación no esté asociada a un evento cancelado
CREATE OR REPLACE FUNCTION public.verificar_evento_no_cancelado()
RETURNS TRIGGER AS $$
DECLARE
  nombre_estatus TEXT;
BEGIN
  -- Obtenemos el nombre del estatus del evento relacionado
  SELECT e2.nombre
  INTO nombre_estatus
  FROM public.evento ev
  JOIN public.estatus e2 ON e2.id_estatus = ev.id_estatus
  WHERE ev.id_evento = NEW.id_evento;

  -- Si el evento no existe, también bloqueamos (por seguridad)
  IF nombre_estatus IS NULL THEN
    RAISE EXCEPTION 'El evento con id % no existe.', NEW.id_evento;
  END IF;

  -- Validamos que el evento no esté cancelado
  IF nombre_estatus = 'Cancelada' THEN
    RAISE EXCEPTION 'No se puede asociar la reservación al evento %, porque está CANCELADO.', NEW.id_evento;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_evento_no_cancelado
BEFORE INSERT OR UPDATE OF id_evento
ON public.reservacion
FOR EACH ROW
EXECUTE FUNCTION public.verificar_evento_no_cancelado();

-- Función para verificar que el motivo de cancelación se registre correctamente según el estatus
CREATE OR REPLACE FUNCTION public.verificar_motivo_cancelacion()
RETURNS TRIGGER AS $$
DECLARE
  nombre_estatus TEXT;
BEGIN
  -- Obtener el nombre del estatus asociado
  SELECT nombre
  INTO nombre_estatus
  FROM public.estatus
  WHERE id_estatus = NEW.id_estatus;

  -- Si el evento o reservación está cancelado:
  IF nombre_estatus = 'Cancelada' THEN
    IF NEW.motivo IS NULL THEN
      RAISE EXCEPTION 'Debe especificarse un motivo cuando el estatus es "Cancelada".';
    END IF;
  ELSE
    -- Si NO está cancelado, motivo debe ser NULL
    IF NEW.motivo IS NOT NULL THEN
      RAISE EXCEPTION 'El motivo solo debe registrarse si el estatus es "Cancelada".';
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_evento_motivo_cancelacion
BEFORE INSERT OR UPDATE OF id_estatus, motivo
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.verificar_motivo_cancelacion();

CREATE TRIGGER trg_reservacion_motivo_cancelacion
BEFORE INSERT OR UPDATE OF id_estatus, motivo
ON public.reservacion
FOR EACH ROW
EXECUTE FUNCTION public.verificar_motivo_cancelacion();

-- Función para validar que un evento pueda cambiar a estatus 'Realizada'
-- Función de validación
CREATE OR REPLACE FUNCTION public.evento_validar_realizada()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_es_realizada boolean;
  v_mega boolean;
  v_resv_autorizada boolean;
BEGIN
  -- ¿El nuevo id_estatus corresponde a 'Realizada'?
  SELECT (e.nombre = 'Realizada')
    INTO v_es_realizada
  FROM public.estatus e
  WHERE e.id_estatus = NEW.id_estatus;

  -- Si no es 'Realizada', no aplican estas validaciones
  IF COALESCE(v_es_realizada, false) IS FALSE THEN
    RETURN NEW;
  END IF;

  -- Validación de recinto
  SELECT r.mega_evento
    INTO v_mega
  FROM public.recinto r
  WHERE r.id = NEW.id_recinto;

  IF v_mega IS NULL THEN
    RAISE EXCEPTION
      'No se encontró el recinto (id=%) para validar el estatus "Realizada".',
      NEW.id_recinto
      USING ERRCODE = '23503';
  END IF;

  -- Comparación con "fecha actual"
  -- Si evento.fecha_inicio es DATE, CURRENT_DATE es ideal.
  -- Si es TIMESTAMP, cambia CURRENT_DATE por NOW() si prefieres precisión a nivel de tiempo.
  IF v_mega THEN
    -- Caso mega_evento = true: solo fecha futura
    IF NOT (NEW.fecha_inicio > CURRENT_DATE) THEN
      RAISE EXCEPTION
        'Para recintos mega_evento=true, fecha_inicio (%) debe ser > fecha actual (%).',
        NEW.fecha_inicio, CURRENT_DATE
        USING ERRCODE = '23514';
    END IF;

  ELSE
    -- Caso mega_evento = false: reservación autorizada + fecha futura
    IF NEW.id_reservacion IS NULL THEN
      RAISE EXCEPTION
        'Se requiere id_reservacion para eventos en recintos mega_evento=false cuando el estatus es "Realizada".'
        USING ERRCODE = '23514';
    END IF;

    SELECT (es.nombre = 'Autorizada')
      INTO v_resv_autorizada
    FROM public.reservacion re
    JOIN public.estatus es ON es.id_estatus = re.id_estatus
    WHERE re.id = NEW.id_reservacion;

    IF COALESCE(v_resv_autorizada, false) IS FALSE THEN
      RAISE EXCEPTION
        'La reservación (id=%) no tiene estatus "Autorizada"; no se permite "Realizada" en evento.',
        NEW.id_reservacion
        USING ERRCODE = '23514';
    END IF;

    IF NOT (NEW.fecha_inicio > CURRENT_DATE) THEN
      RAISE EXCEPTION
        'Para recintos mega_evento=false, fecha_inicio (%) debe ser > fecha actual (%).',
        NEW.fecha_inicio, CURRENT_DATE
        USING ERRCODE = '23514';
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_evento_validar_realizada
BEFORE INSERT OR UPDATE OF id_estatus, id_recinto, id_reservacion, fecha_inicio
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.evento_validar_realizada();


-- Función para validar que un evento referenciado a un mega_evento esté dentro del rango de fechas y horarios del mega_evento
CREATE OR REPLACE FUNCTION public.evento_validar_rango_mega()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_mega_fecha_ini date;
  v_mega_hora_ini  time;
  v_mega_fecha_fin date;
  v_mega_hora_fin  time;

  v_ev_ini_ts   timestamp;
  v_ev_fin_ts   timestamp;
  v_mega_ini_ts timestamp;
  v_mega_fin_ts timestamp;
BEGIN
  -- Solo aplica si hay referencia a mega_evento
  IF NEW.id_mega_evento IS NULL THEN
    RETURN NEW;
  END IF;

  -- Verifica que el mega_evento exista y trae su rango
  SELECT m.fecha_inicio, m.horario_inicio, m.fecha_fin, m.horario_fin
    INTO v_mega_fecha_ini, v_mega_hora_ini, v_mega_fecha_fin, v_mega_hora_fin
  FROM public.mega_evento m
  WHERE m.id = NEW.id_mega_evento;

  IF v_mega_fecha_ini IS NULL THEN
    RAISE EXCEPTION
      'No se encontró el mega_evento (id=%) referenciado por el evento.',
      NEW.id_mega_evento
      USING ERRCODE = '23503'; -- foreign_key_violation semántica
  END IF;

  -- Verifica que el evento tenga todas las columnas requeridas
  IF NEW.fecha_inicio IS NULL OR NEW.horario_inicio IS NULL
     OR NEW.fecha_fin IS NULL OR NEW.horario_fin IS NULL THEN
    RAISE EXCEPTION
      'El evento referenciado a un mega_evento debe definir fecha_inicio, horario_inicio, fecha_fin y horario_fin.'
      USING ERRCODE = '23514';
  END IF;

  -- Construye timestamps combinando fecha + hora
  v_ev_ini_ts   := NEW.fecha_inicio::timestamp + NEW.horario_inicio;
  v_ev_fin_ts   := NEW.fecha_fin::timestamp   + NEW.horario_fin;
  v_mega_ini_ts := v_mega_fecha_ini::timestamp + v_mega_hora_ini;
  v_mega_fin_ts := v_mega_fecha_fin::timestamp + v_mega_hora_fin;

  -- Coherencia interna del evento
  IF v_ev_fin_ts < v_ev_ini_ts THEN
    RAISE EXCEPTION
      'La fecha/horario de fin del evento (%) es anterior al inicio (%).',
      v_ev_fin_ts, v_ev_ini_ts
      USING ERRCODE = '23514';
  END IF;

  -- Validación de inclusión dentro del rango del mega_evento (inclusivo)
  IF NOT (v_ev_ini_ts >= v_mega_ini_ts AND v_ev_fin_ts <= v_mega_fin_ts) THEN
    RAISE EXCEPTION
      'El evento (% – %) debe estar dentro del rango del mega_evento (% – %).',
      v_ev_ini_ts, v_ev_fin_ts, v_mega_ini_ts, v_mega_fin_ts
      USING ERRCODE = '23514';
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_evento_validar_rango_mega
BEFORE INSERT OR UPDATE OF id_mega_evento, fecha_inicio, horario_inicio, fecha_fin, horario_fin
ON public.evento
FOR EACH ROW
EXECUTE FUNCTION public.evento_validar_rango_mega();
