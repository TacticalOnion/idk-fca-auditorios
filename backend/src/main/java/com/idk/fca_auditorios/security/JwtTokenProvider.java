package com.idk.fca_auditorios.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.time.Instant;
import java.util.Date;
import java.util.Map;

@Component
public class JwtTokenProvider {

    private final Key key;
    private final long jwtExpirationMillis;
    private final String issuer;

    public JwtTokenProvider(
            @Value("${app.jwt.secret}") String secret,
            @Value("${app.jwt.expiration:86400000}") long jwtExpirationMillis, // 24h por defecto
            @Value("${app.jwt.issuer:IDK-FCA}") String issuer
    ) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.jwtExpirationMillis = jwtExpirationMillis;
        this.issuer = issuer;
    }

    /** Mantiene compatibilidad con AuthController: generate(subject, claims) */
    public String generate(String subject, Map<String, Object> claims) {
        Instant now = Instant.now();
        Date iat = Date.from(now);
        Date exp = new Date(iat.getTime() + jwtExpirationMillis);

        return Jwts.builder()
                .setSubject(subject)
                .setIssuer(issuer)
                .setIssuedAt(iat)
                .setExpiration(exp)
                .addClaims(claims == null ? Map.of() : claims)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    /** Útil si en algún punto generas sin claims */
    public String generate(String subject) {
        return generate(subject, Map.of());
    }

    public boolean validate(String token) {
        try {
            parseAllClaims(token);
            return true;
        } catch (JwtException | IllegalArgumentException ex) {
            // log opcional
            return false;
        }
    }

    public String getSubject(String token) {
        return parseAllClaims(token).getSubject();
    }

    public Claims parseAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .requireIssuer(issuer)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}
