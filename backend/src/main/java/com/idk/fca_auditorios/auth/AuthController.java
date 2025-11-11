package com.idk.fca_auditorios.auth;

import com.idk.fca_auditorios.security.JwtTokenProvider;
import com.idk.fca_auditorios.security.Sha256PasswordEncoder;
import com.idk.fca_auditorios.usuario.UsuarioRepository;
import jakarta.validation.constraints.NotBlank;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
  private final UsuarioRepository repo;
  private final JwtTokenProvider jwt;
  private final Sha256PasswordEncoder encoder;

  public AuthController(UsuarioRepository repo, JwtTokenProvider jwt, Sha256PasswordEncoder encoder) {
    this.repo = repo; this.jwt = jwt; this.encoder = encoder;
  }

  // 1) x-www-form-urlencoded
  @PostMapping(value = "/login", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
  public ResponseEntity<?> loginForm(@RequestParam @NotBlank String username,
                                     @RequestParam @NotBlank String password) {
    return doLogin(username, password);
  }

  // 2) application/json
  public record LoginRequest(String username, String password) {}
  @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<?> loginJson(@RequestBody LoginRequest req) {
    return doLogin(req.username(), req.password());
  }

  private ResponseEntity<?> doLogin(String username, String password) {
    var opt = repo.findUserForLogin(username);
    if (opt.isEmpty()) return ResponseEntity.status(401).body(Map.of("message","Credenciales inválidas"));
    var u = opt.get();
    if (!u.isActivo()) return ResponseEntity.status(403).body(Map.of("message","Usuario inactivo"));
    if (!encoder.matches(password, u.getContrasenia()))
      return ResponseEntity.status(401).body(Map.of("message","Credenciales inválidas"));
    String token = jwt.generate(u.getNombreUsuario(), Map.of("role", u.getRolNombre()));
    return ResponseEntity.ok(Map.of("access_token", token, "token_type","Bearer"));
  }

  /*TODO borrar*/
  @PostMapping("/login")
  public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password) {
    var opt = repo.findUserForLogin(username);
    if (opt.isEmpty()) return ResponseEntity.status(401).body(Map.of("message","Credenciales inválidas"));

    var u = opt.get();
    System.out.println("[LOGIN] user=" + u.getNombreUsuario()
        + " activo=" + u.isActivo()
        + " stored.len=" + (u.getContrasenia()==null?-1:u.getContrasenia().length())
        + " stored.hash=" + u.getContrasenia());
    System.out.println("[LOGIN] calc.hash=" + encoder.encode(password));

    if (!u.isActivo()) return ResponseEntity.status(403).body(Map.of("message","Usuario inactivo"));
    if (!encoder.matches(password, u.getContrasenia()))
      return ResponseEntity.status(401).body(Map.of("message","Credenciales inválidas"));

    String token = jwt.generate(u.getNombreUsuario(), Map.of("role", u.getRolNombre()));
    return ResponseEntity.ok(Map.of("access_token", token, "token_type","Bearer"));
  }

}
