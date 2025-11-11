package com.idk.fca_auditorios.security;

import com.idk.fca_auditorios.usuario.UsuarioRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableMethodSecurity
public class SecurityConfig {

  @Bean PasswordEncoder passwordEncoder() { return new Sha256PasswordEncoder(); }

  @Bean
  public UserDetailsService userDetailsService(UsuarioRepository repo) {
    return username -> repo.findUserForLogin(username)
        .map(u -> User.withUsername(u.getNombreUsuario())
            .password(u.getContrasenia()) // hash ya viene de DB
            .authorities("ROLE_" + u.getRolNombre().toUpperCase())
            .disabled(!u.isActivo())
            .build())
        .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));
  }

  @Bean
  public SecurityFilterChain filterChain(HttpSecurity http, JwtAuthFilter jwtAuthFilter) throws Exception {
    http.csrf(csrf -> csrf.disable());
    http.authorizeHttpRequests(auth -> auth
        .requestMatchers("/api/auth/login", "/v3/api-docs/**", "/swagger-ui/**").permitAll()
        .requestMatchers(HttpMethod.GET, "/health").permitAll()
        .anyRequest().authenticated()
    );
    http.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
    http.httpBasic(Customizer.withDefaults());
    return http.build();
  }

  @Bean
  AuthenticationManager authenticationManager(AuthenticationConfiguration cfg) throws Exception {
    return cfg.getAuthenticationManager();
  }
}
