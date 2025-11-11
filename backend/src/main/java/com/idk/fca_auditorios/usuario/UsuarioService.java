package com.idk.fca_auditorios.usuario;

import com.idk.fca_auditorios.security.Sha256PasswordEncoder;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {
  private final UsuarioRepository repo;
  private final Sha256PasswordEncoder encoder;

  public UsuarioService(UsuarioRepository repo, Sha256PasswordEncoder encoder) {
    this.repo = repo; this.encoder = encoder;
  }

  public Usuario getByUsernameOrThrow(String username) {
    return repo.findByNombreUsuarioIgnoreCase(username)
        .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));
  }

  @Transactional
  public void resetPassword(Long idUsuario, String nuevaPlano) {
    Usuario u = repo.findById(idUsuario).orElseThrow();
    u.setContrasenia(encoder.encode(nuevaPlano));
  }
}
