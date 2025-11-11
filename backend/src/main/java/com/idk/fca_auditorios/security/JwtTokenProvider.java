package com.idk.fca_auditorios.security;

import com.idk.fca_auditorios.config.AppProperties;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.time.Instant;
import java.util.Date;
import java.util.Map;

@Component
public class JwtTokenProvider {
  private final AppProperties props;
  private final Key key;

  public JwtTokenProvider(AppProperties props) {
    this.props = props;
    String secret = props.getSecret();
    // Opción "crudo":
    this.key = Keys.hmacShaKeyFor(secret.getBytes(java.nio.charset.StandardCharsets.UTF_8));
  }

  public String generate(String subject, Map<String, Object> claims) {
    Instant now = Instant.now();
    Instant exp = now.plusSeconds(props.getExpirationMinutes() * 60L);
    return Jwts.builder()
        .setSubject(subject)
        .addClaims(claims)
        .setIssuer(props.getIssuer())
        .setIssuedAt(Date.from(now))
        .setExpiration(Date.from(exp))
        .signWith(key, SignatureAlgorithm.HS256)
        .compact();
  }

  public String getSubject(String token) {
    return Jwts.parserBuilder().setSigningKey(key).build()
        .parseClaimsJws(token).getBody().getSubject();
  }
}
