BEGIN;
-- FKs “simples”
-- area
CREATE INDEX IF NOT EXISTS idx_area_responsable ON public.area (id_responsable_area);

-- periodo
CREATE INDEX IF NOT EXISTS idx_periodo_tipo_periodo ON public.periodo (id_tipo_periodo);
CREATE INDEX IF NOT EXISTS idx_periodo_calendario ON public.periodo (id_calendario_escolar);

-- puesto
CREATE INDEX IF NOT EXISTS idx_puesto_area ON public.puesto (id_area);

-- usuario
CREATE INDEX IF NOT EXISTS idx_usuario_rol ON public.usuario (id_rol_usuario);
CREATE INDEX IF NOT EXISTS idx_usuario_puesto ON public.usuario (id_puesto);

-- ponente
CREATE INDEX IF NOT EXISTS idx_ponente_pais ON public.ponente (id_pais);

-- evento
CREATE INDEX IF NOT EXISTS idx_evento_categoria ON public.evento (id_categoria);
CREATE INDEX IF NOT EXISTS idx_evento_mega_evento ON public.evento (id_mega_evento);
CREATE INDEX IF NOT EXISTS idx_evento_calendario ON public.evento (id_calendario_escolar);

-- empresa
CREATE INDEX IF NOT EXISTS idx_empresa_pais ON public.empresa (id_pais);

-- experiencia
CREATE INDEX IF NOT EXISTS idx_experiencia_empresa ON public.experiencia (id_empresa);

-- grado
CREATE INDEX IF NOT EXISTS idx_grado_nivel ON public.grado (id_nivel);
CREATE INDEX IF NOT EXISTS idx_grado_institucion ON public.grado (id_institucion);
CREATE INDEX IF NOT EXISTS idx_grado_pais ON public.grado (id_pais);

-- recinto
CREATE INDEX IF NOT EXISTS idx_recinto_tipo ON public.recinto (id_tipo_recinto);

-- auditoria
CREATE INDEX IF NOT EXISTS idx_auditoria_usuario ON public.auditoria (id_usuario);
CREATE INDEX IF NOT EXISTS idx_auditoria_tabla_registro ON public.auditoria (nombre_tabla, id_registro_afectado);
CREATE INDEX IF NOT EXISTS idx_auditoria_fecha ON public.auditoria (fecha_hora);

-- Tablas transitivas
-- rolxpermiso
CREATE INDEX IF NOT EXISTS idx_rolxpermiso_permiso ON public.rolxpermiso (id_permiso);

-- evento_organizador
CREATE INDEX IF NOT EXISTS idx_evento_organizador_usuario ON public.evento_organizador (id_usuario);

-- participacion
CREATE INDEX IF NOT EXISTS idx_participacion_ponente ON public.participacion (id_ponente);

-- reservacion
CREATE INDEX IF NOT EXISTS idx_reservacion_recinto ON public.reservacion (id_recinto);

-- eventoxequipamiento
CREATE INDEX IF NOT EXISTS idx_eventoxequipamiento_equipamiento ON public.eventoxequipamiento (id_equipamiento);

-- inventario_area
CREATE INDEX IF NOT EXISTS idx_inventario_area_area ON public.inventario_area (id_area);

-- inventario_recinto
CREATE INDEX IF NOT EXISTS idx_inventario_recinto_recinto ON public.inventario_recinto (id_recinto);

-- semblanzaxreconocimiento
CREATE INDEX IF NOT EXISTS idx_semblanzaxreconocimiento_reconocimiento ON public.semblanzaxreconocimiento (id_reconocimiento);

-- semblanzaxexperiencia
CREATE INDEX IF NOT EXISTS idx_semblanzaxexperiencia_experiencia ON public.semblanzaxexperiencia (id_experiencia);

-- semblanzaxgrado
CREATE INDEX IF NOT EXISTS idx_semblanzaxgrado_grado ON public.semblanzaxgrado (id_grado);

COMMIT;