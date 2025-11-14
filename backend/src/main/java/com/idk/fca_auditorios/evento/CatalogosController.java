package com.idk.fca_auditorios.evento;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * Endpoints de catálogos simples usados por los formularios del frontend.
 *
 * Todos los endpoints devuelven objetos con al menos:
 *   - id    (Integer)
 *   - nombre (String)
 *
 * Pensado para mapearse directo al tipo Option del frontend.
 *
 * Rutas:
 *   /api/catalogos/categorias
 *   /api/catalogos/mega-eventos
 *   /api/catalogos/recintos
 *   /api/catalogos/funcionarios
 *   /api/catalogos/equipamiento
 *   /api/catalogos/paises
 *   /api/catalogos/niveles
 *   /api/catalogos/empresas
 *   /api/catalogos/instituciones
 */
@RestController
@RequestMapping("/api/catalogos")
public class CatalogosController {

  private final JdbcTemplate jdbc;

  public CatalogosController(JdbcTemplate jdbc) {
    this.jdbc = jdbc;
  }

  /**
   * Catálogo de categorías de evento.
   *
   * SELECT id_categoria AS id, nombre FROM categoria;
   */
  @GetMapping("/categorias")
  public List<Map<String, Object>> categorias() {
    return jdbc.queryForList("""
        SELECT id_categoria AS id,
               nombre
          FROM categoria
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de mega eventos.
   *
   * SELECT id_evento AS id, nombre FROM evento WHERE mega_evento = TRUE;
   */
  @GetMapping("/mega-eventos")
  public List<Map<String, Object>> megaEventos() {
    return jdbc.queryForList("""
        SELECT id_evento AS id,
               nombre
          FROM evento
         WHERE mega_evento = TRUE
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de recintos.
   *
   * SELECT id_recinto AS id, nombre FROM recinto;
   */
  @GetMapping("/recintos")
  public List<Map<String, Object>> recintos() {
    return jdbc.queryForList("""
        SELECT id_recinto AS id,
               nombre
          FROM recinto
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de usuarios con rol FUNCIONARIO.
   *
   * SELECT id_usuario AS id, nombreCompleto AS nombre.
   */
  @GetMapping("/funcionarios")
  public List<Map<String, Object>> funcionarios() {
    return jdbc.queryForList("""
        SELECT u.id_usuario AS id,
               TRIM(
                 COALESCE(u.nombre,'') || ' ' ||
                 COALESCE(u.apellido_paterno,'') || ' ' ||
                 COALESCE(u.apellido_materno,'')
               ) AS nombre
          FROM usuario u
          JOIN rol_usuario r ON r.id_rol_usuario = u.id_rol_usuario
         WHERE LOWER(r.nombre) = 'funcionario'
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de equipamiento disponible.
   *
   * SELECT id_equipamiento AS id, nombre FROM equipamiento WHERE existencia = TRUE;
   */
  @GetMapping("/equipamiento")
  public List<Map<String, Object>> equipamientoDisponible() {
    return jdbc.queryForList("""
        SELECT id_equipamiento AS id,
               nombre
          FROM equipamiento
         WHERE existencia = TRUE
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de países.
   *
   * SELECT id_pais AS id, nombre FROM pais;
   */
  @GetMapping("/paises")
  public List<Map<String, Object>> paises() {
    return jdbc.queryForList("""
        SELECT id_pais AS id,
               nombre
          FROM pais
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de niveles académicos.
   *
   * SELECT id_nivel AS id, nombre FROM nivel;
   */
  @GetMapping("/niveles")
  public List<Map<String, Object>> niveles() {
    return jdbc.queryForList("""
        SELECT id_nivel AS id,
               nombre
          FROM nivel
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de empresas.
   *
   * SELECT id_empresa AS id, nombre FROM empresa;
   *
   * Nota: para crear nuevas empresas se usa el endpoint POST /api/empresas
   * definido en EmpresaController.
   */
  @GetMapping("/empresas")
  public List<Map<String, Object>> empresas() {
    return jdbc.queryForList("""
        SELECT id_empresa AS id,
               nombre
          FROM empresa
         ORDER BY nombre
        """);
  }

  /**
   * Catálogo de instituciones.
   *
   * SELECT id_institucion AS id, nombre FROM institucion;
   *
   * Nota: para crear nuevas instituciones se usa el endpoint POST /api/instituciones
   * definido en InstitucionController.
   */
  @GetMapping("/instituciones")
  public List<Map<String, Object>> instituciones() {
    return jdbc.queryForList("""
        SELECT id_institucion AS id,
               nombre
          FROM institucion
         ORDER BY nombre
        """);
  }
}
