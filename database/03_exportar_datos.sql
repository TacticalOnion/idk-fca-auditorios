\set ON_ERROR_STOP on
\encoding UTF8
SET client_encoding TO 'UTF8';
SET search_path TO public;

\pset tuples_only on
\pset format unaligned

SELECT jsonb_pretty(
  jsonb_build_object(
    -- Tablas base (sin sustitución de FKs)
    'permiso',                     COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM permiso t), '[]'::jsonb),
    'rol_usuario',                 COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM rol_usuario t), '[]'::jsonb),
    'area',                        COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM area t), '[]'::jsonb),
    'rol_participacion',           COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM rol_participacion t), '[]'::jsonb),
    'nivel',                       COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM nivel t), '[]'::jsonb),
    'institucion',                 COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM institucion t), '[]'::jsonb),
    'categoria',                   COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM categoria t), '[]'::jsonb),
    'integrante',                  COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM integrante t), '[]'::jsonb),
    'pais',                        COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM pais t), '[]'::jsonb),
    'tipo',                        COALESCE((SELECT jsonb_agg(to_jsonb(t)) FROM tipo t), '[]'::jsonb),

    -- equipamiento : id_area = area(id_area)
    'equipamiento',                COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(eq) - 'id_area')
                                          || jsonb_build_object(
                                               'area', jsonb_build_object('nombre', a.nombre)
                                             )
                                        )
                                        FROM equipamiento eq
                                        JOIN area a ON a.id_area = eq.id_area
                                      ), '[]'::jsonb),

    -- puesto : id_area = area(id_area)
    'puesto',                      COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(pu) - 'id_area')
                                          || jsonb_build_object(
                                               'area', jsonb_build_object('nombre', a.nombre)
                                             )
                                        )
                                        FROM puesto pu
                                        JOIN area a ON a.id_area = pu.id_area
                                      ), '[]'::jsonb),

    -- usuario : id_rol_usuario = rol_usuario(id_rol_usuario), id_puesto = puesto(id_puesto)
    'usuario',                     COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(u) - 'id_rol_usuario' - 'id_puesto')
                                          || jsonb_build_object(
                                               'rol_usuario', jsonb_build_object('nombre', ru.nombre),
                                               'puesto',       jsonb_build_object('nombre', pu.nombre)
                                             )
                                        )
                                        FROM usuario u
                                        JOIN rol_usuario ru ON ru.id_rol_usuario = u.id_rol_usuario
                                        JOIN puesto pu       ON pu.id_puesto     = u.id_puesto
                                      ), '[]'::jsonb),

    -- evento : id_categoria = categoria(id_categoria), id_mega_evento = evento(id_evento)
    'evento',                      COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(e) - 'id_categoria' - 'id_mega_evento')
                                          || jsonb_build_object(
                                               'categoria',   jsonb_build_object('nombre', c.nombre),
                                               'mega_evento', CASE WHEN me.id_evento IS NULL
                                                                   THEN NULL
                                                                   ELSE jsonb_build_object('nombre', me.nombre)
                                                              END
                                             )
                                        )
                                        FROM evento e
                                        JOIN categoria c     ON c.id_categoria = e.id_categoria
                                        LEFT JOIN evento me   ON me.id_evento   = e.id_mega_evento
                                      ), '[]'::jsonb),

    -- grado : id_nivel=nivel(id_nivel), id_institucion=institucion(id_institucion), id_pais=pais(id_pais)
    'grado',                       COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(g) - 'id_nivel' - 'id_institucion' - 'id_pais')
                                          || jsonb_build_object(
                                               'nivel',       jsonb_build_object('nombre', n.nombre),
                                               'institucion', jsonb_build_object('nombre', i.nombre),
                                               'pais',        jsonb_build_object('nombre', p.nombre)
                                             )
                                        )
                                        FROM grado g
                                        JOIN nivel n        ON n.id_nivel        = g.id_nivel
                                        JOIN institucion i  ON i.id_institucion  = g.id_institucion
                                        JOIN pais p         ON p.id_pais         = g.id_pais
                                      ), '[]'::jsonb),

    -- recinto : id_tipo = tipo(id_tipo)
    'recinto',                     COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(r) - 'id_tipo')
                                          || jsonb_build_object(
                                               'tipo', jsonb_build_object('nombre', t.nombre)
                                             )
                                        )
                                        FROM recinto r
                                        JOIN tipo t ON t.id_tipo = r.id_tipo
                                      ), '[]'::jsonb),

    -- rolxpermiso : id_rol_usuario = rol_usuario(id_rol_usuario), id_permiso = permiso(id_permiso)
    'rolxpermiso',                 COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(rx) - 'id_rol_usuario' - 'id_permiso')
                                          || jsonb_build_object(
                                               'rol_usuario', jsonb_build_object('nombre', ru.nombre),
                                               'permiso',     jsonb_build_object(
                                                                 'recurso', p.recurso,
                                                                 'accion',  p.accion,
                                                                 'alcance', p.alcance
                                                               )
                                             )
                                        )
                                        FROM rolxpermiso rx
                                        JOIN rol_usuario ru ON ru.id_rol_usuario = rx.id_rol_usuario
                                        JOIN permiso p      ON p.id_permiso      = rx.id_permiso
                                      ), '[]'::jsonb),

    -- evento_organizador : id_evento=evento(id_evento), id_usuario=usuario(id_usuario)
    'evento_organizador',          COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(eo) - 'id_evento' - 'id_usuario')
                                          || jsonb_build_object(
                                               'evento',  jsonb_build_object('nombre', e.nombre),
                                               'usuario', jsonb_build_object(
                                                            'nombre', u.nombre,
                                                            'apellido_paterno',  u.apellido_paterno,
                                                            'apellido_materno',  u.apellido_materno
                                                          )
                                             )
                                        )
                                        FROM evento_organizador eo
                                        JOIN evento e  ON e.id_evento   = eo.id_evento
                                        JOIN usuario u ON u.id_usuario  = eo.id_usuario
                                      ), '[]'::jsonb),

    -- participacion : id_evento=evento(id_evento), id_integrante=integrante(id_integrante), id_rol_participacion=rol_participacion(id_rol_participacion)
    'participacion',               COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(pa) - 'id_evento' - 'id_integrante' - 'id_rol_participacion')
                                          || jsonb_build_object(
                                               'evento',            jsonb_build_object('nombre', e.nombre),
                                               'integrante',        jsonb_build_object(
                                                                        'nombre', i.nombre,
                                                                        'apellido_paterno',  i.apellido_paterno,
                                                                        'apellido_materno',  i.apellido_materno
                                                                     ),
                                               'rol_participacion', jsonb_build_object('nombre', rp.nombre)
                                             )
                                        )
                                        FROM participacion pa
                                        JOIN evento e             ON e.id_evento              = pa.id_evento
                                        JOIN integrante i         ON i.id_integrante          = pa.id_integrante
                                        JOIN rol_participacion rp ON rp.id_rol_participacion  = pa.id_rol_participacion
                                      ), '[]'::jsonb),

    -- integrantexgrado : id_integrante=integrante(id_integrante), id_grado=grado(id_grado)
    'integrantexgrado',            COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(ixg) - 'id_integrante' - 'id_grado')
                                          || jsonb_build_object(
                                               'integrante', jsonb_build_object(
                                                               'nombre', i.nombre,
                                                               'apellido_paterno',  i.apellido_paterno,
                                                               'apellido_materno',  i.apellido_materno
                                                             ),
                                               'grado',      jsonb_build_object('titulo', g.titulo)
                                             )
                                        )
                                        FROM integrantexgrado ixg
                                        JOIN integrante i ON i.id_integrante = ixg.id_integrante
                                        JOIN grado g      ON g.id_grado      = ixg.id_grado
                                      ), '[]'::jsonb),

    -- reservacion : id_evento=evento(id_evento), id_recinto=recinto(id_recinto)
    'reservacion',                 COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(rz) - 'id_evento' - 'id_recinto')
                                          || jsonb_build_object(
                                               'evento',  jsonb_build_object('nombre', e.nombre),
                                               'recinto', jsonb_build_object('nombre', r.nombre)
                                             )
                                        )
                                        FROM reservacion rz
                                        JOIN evento e  ON e.id_evento   = rz.id_evento
                                        JOIN recinto r ON r.id_recinto  = rz.id_recinto
                                      ), '[]'::jsonb),

    -- reservacionxequipamiento : id_evento=evento(id_evento), id_recinto=recinto(id_recinto), id_equipamiento=equipamiento(id_equipamiento)
    'reservacionxequipamiento',    COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(rxe) - 'id_evento' - 'id_recinto' - 'id_equipamiento')
                                          || jsonb_build_object(
                                               'evento',       jsonb_build_object('nombre', e.nombre),
                                               'recinto',      jsonb_build_object('nombre', r.nombre),
                                               'equipamiento', jsonb_build_object('nombre', eq.nombre)
                                             )
                                        )
                                        FROM reservacionxequipamiento rxe
                                        JOIN evento e        ON e.id_evento        = rxe.id_evento
                                        JOIN recinto r       ON r.id_recinto       = rxe.id_recinto
                                        JOIN equipamiento eq ON eq.id_equipamiento = rxe.id_equipamiento
                                      ), '[]'::jsonb),

    -- area_inventario : id_area=area(id_area), id_equipamiento=equipamiento(id_equipamiento)
    'area_inventario',             COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(ai) - 'id_area' - 'id_equipamiento')
                                          || jsonb_build_object(
                                               'area',         jsonb_build_object('nombre', a.nombre),
                                               'equipamiento', jsonb_build_object('nombre', e.nombre)
                                             )
                                        )
                                        FROM area_inventario ai
                                        JOIN area a         ON a.id_area          = ai.id_area
                                        JOIN equipamiento e ON e.id_equipamiento  = ai.id_equipamiento
                                      ), '[]'::jsonb),

    -- recinto_inventario : id_recinto=recinto(id_recinto), id_equipamiento=equipamiento(id_equipamiento)
    'recinto_inventario',          COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(ri) - 'id_recinto' - 'id_equipamiento')
                                          || jsonb_build_object(
                                               'recinto',      jsonb_build_object('nombre', r.nombre),
                                               'equipamiento', jsonb_build_object('nombre', e.nombre)
                                             )
                                        )
                                        FROM recinto_inventario ri
                                        JOIN recinto r      ON r.id_recinto       = ri.id_recinto
                                        JOIN equipamiento e ON e.id_equipamiento  = ri.id_equipamiento
                                      ), '[]'::jsonb),

    -- fotografia : id_recinto=recinto(id_recinto)
    'fotografia',                  COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(f) - 'id_recinto')
                                          || jsonb_build_object(
                                               'recinto', jsonb_build_object('nombre', r.nombre)
                                             )
                                        )
                                        FROM fotografia f
                                        JOIN recinto r ON r.id_recinto = f.id_recinto
                                      ), '[]'::jsonb),

    -- auditoria : id_usuario=usuario(id_usuario)
    'auditoria',                   COALESCE((
                                        SELECT jsonb_agg(
                                          (to_jsonb(aud) - 'id_usuario')
                                          || jsonb_build_object(
                                               'usuario', jsonb_build_object(
                                                            'nombre', audu.nombre,
                                                            'apellido_paterno',  audu.apellido_paterno,
                                                            'apellido_materno',  audu.apellido_materno
                                                          )
                                             )
                                        )
                                        FROM auditoria aud
                                        JOIN usuario audu ON audu.id_usuario = aud.id_usuario
                                      ), '[]'::jsonb)
  )
);

\g datos.json
\echo 'Exportación completada: datos.json'
