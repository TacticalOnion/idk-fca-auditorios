package com.idk.fca_auditorios.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtAuthFilter extends OncePerRequestFilter {

  private final JwtTokenProvider jwtTokenProvider;
  private final UserDetailsService userDetailsService;

  public JwtAuthFilter(JwtTokenProvider jwtTokenProvider, UserDetailsService userDetailsService) {
    this.jwtTokenProvider = jwtTokenProvider;
    this.userDetailsService = userDetailsService;
  }

  @Override
  protected void doFilterInternal(@NonNull HttpServletRequest request,
                                  @NonNull HttpServletResponse response,
                                  @NonNull FilterChain filterChain)
      throws ServletException, IOException {
    // Formato esperado: Authorization: Bearer <token>
    String header = request.getHeader("Authorization");
    if (StringUtils.hasText(header) && header.startsWith("Bearer ")) {
      String token = header.substring(7);
      try {
        String username = jwtTokenProvider.getSubject(token);
        if (username != null &&
            org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication() == null) {
          UserDetails userDetails = userDetailsService.loadUserByUsername(username);
          var auth = new UsernamePasswordAuthenticationToken(
              userDetails.getUsername(),
              userDetails.getPassword(),
              userDetails.getAuthorities()
          );
          auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
          org.springframework.security.core.context.SecurityContextHolder.getContext().setAuthentication(auth);
        }
      } catch (Exception ignored) {
        // Si el token es inválido/expirado, no autenticamos y dejamos seguir la cadena.
      }
    }
    filterChain.doFilter(request, response);
  }
}
