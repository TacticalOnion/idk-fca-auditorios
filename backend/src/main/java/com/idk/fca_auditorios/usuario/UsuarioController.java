package com.idk.fca_auditorios.usuario;

import com.idk.fca_auditorios.usuario.dto.UsuarioCreateRequest;
import com.idk.fca_auditorios.usuario.dto.UsuarioUpdateRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {
  private final UsuarioService service;
  private final UsuarioRepository repo;
  private final JdbcTemplate jdbc;

  public UsuarioController(UsuarioService service, UsuarioRepository repo, JdbcTemplate jdbc) {
    this.service = service;
    this.repo = repo;
    this.jdbc = jdbc;
  }

  @GetMapping("/me")
  public Usuario me(Principal principal) {
    return service.getByUsernameOrThrow(principal.getName());
  }

  @GetMapping
  @PreAuthorize("hasRole('superadministrador')")
  public List<Usuario> listAll() {
    return repo.findAll();
  }

  @PostMapping("/{id}/reset-password")
  @PreAuthorize("hasRole('superadministrador')")
  public void resetPassword(@PathVariable Long id, @RequestParam @NotBlank String nueva) {
    service.resetPassword(id, nueva);
  }

  // ---------- Helpers para evitar “dead code” por checks de null ----------
  private long resolveRolIdByName(String rolNombre) {
    try {
      return jdbc.queryForObject(
          "SELECT id_rol_usuario FROM rol_usuario WHERE LOWER(nombre)=LOWER(?)",
          Long.class, rolNombre
      );
    } catch (EmptyResultDataAccessException e) {
      throw new IllegalArgumentException("Rol no encontrado: " + rolNombre);
    }
  }

  private long resolvePuestoId(Integer idPuesto, String nombrePuesto) {
    if (idPuesto != null) return idPuesto.longValue();
    if (nombrePuesto == null || nombrePuesto.isBlank())
      throw new IllegalArgumentException("Puesto requerido (idPuesto o nombrePuesto)");
    try {
      return jdbc.queryForObject("SELECT id_puesto FROM puesto WHERE nombre = ?", Long.class, nombrePuesto);
    } catch (EmptyResultDataAccessException e) {
      throw new IllegalArgumentException("Puesto no encontrado: " + nombrePuesto);
    }
  }
  // -----------------------------------------------------------------------

  @PostMapping
  @PreAuthorize("hasRole('superadministrador')")
  public Usuario create(@Valid @RequestBody UsuarioCreateRequest b) {
    final long idRol = resolveRolIdByName(b.rol());
    final long idPuesto = resolvePuestoId(b.idPuesto(), b.nombrePuesto());

    // Insert directo (cumplir NOT NULL de rol/puesto)
    String foto = "/usuarios/fotos/foto_usuario_default.png";
    String tel = (b.telefono()==null || b.telefono().isBlank()) ? "0000000000" : b.telefono();
    String cel = (b.celular()==null  || b.celular().isBlank())  ? "0000000000" : b.celular();

    Long id = jdbc.queryForObject("""
      INSERT INTO usuario(foto_usuario, nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno,
                          telefono, celular, correo, activo, id_rol_usuario, id_puesto)
      VALUES(?,?,?,?,?,?,?,?,?,true,?,?) RETURNING id_usuario
    """, Long.class, foto, b.nombreUsuario(), b.rfc(), b.nombre(), b.apellidoPaterno(),
        b.apellidoMaterno(), tel, cel, b.correo(), idRol, idPuesto);

    // Contraseña (hash via service)
    String pass = (b.contrasenia()==null || b.contrasenia().isBlank()) ? "changeme" : b.contrasenia();
    service.resetPassword(id, pass);

    return repo.findById(id).orElseThrow();
  }

  @PatchMapping("/{id}")
  @PreAuthorize("hasRole('superadministrador')")
  public Usuario update(@PathVariable Long id, @Valid @RequestBody UsuarioUpdateRequest b) {
    // 1) Campos simples por JPA
    Usuario u = repo.findById(id).orElseThrow();
    if (b.nombre()!=null) u.setNombre(b.nombre());
    if (b.apellidoPaterno()!=null) u.setApellidoPaterno(b.apellidoPaterno());
    if (b.apellidoMaterno()!=null) u.setApellidoMaterno(b.apellidoMaterno());
    if (b.correo()!=null) u.setCorreo(b.correo());
    if (b.telefono()!=null) u.setTelefono(b.telefono());
    if (b.celular()!=null) u.setCelular(b.celular());
    if (b.rfc()!=null) u.setRfc(b.rfc());
    if (b.activo()!=null) u.setActivo(b.activo());
    repo.save(u);

    // 2) Rol (si vino)
    if (b.rol()!=null && !b.rol().isBlank()) {
      long idRol = resolveRolIdByName(b.rol());
      jdbc.update("UPDATE usuario SET id_rol_usuario=? WHERE id_usuario=?", idRol, id);
    }

    // 3) Puesto (si vino)
    if (b.idPuesto()!=null || (b.nombrePuesto()!=null && !b.nombrePuesto().isBlank())) {
      long idPuesto = resolvePuestoId(b.idPuesto(), b.nombrePuesto());
      jdbc.update("UPDATE usuario SET id_puesto=? WHERE id_usuario=?", idPuesto, id);
    }

    return repo.findById(id).orElseThrow();
  }

  @PostMapping("/{id}/activar")
  @PreAuthorize("hasRole('superadministrador')")
  public Map<String,Object> activar(@PathVariable Long id) {
    jdbc.update("UPDATE usuario SET activo=true WHERE id_usuario=?", id);
    return Map.of("ok", true);
  }

  @PostMapping("/{id}/desactivar")
  @PreAuthorize("hasRole('superadministrador')")
  public Map<String,Object> desactivar(@PathVariable Long id) {
    jdbc.update("UPDATE usuario SET activo=false WHERE id_usuario=?", id);
    return Map.of("ok", true);
  }
}
