package com.idk.fca_auditorios.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "app.jwt")
public class AppProperties {
  private String secret;
  private String issuer;
  private int expirationMinutes;

  public String getSecret() { return secret; }
  public void setSecret(String secret) { this.secret = secret; }
  public String getIssuer() { return issuer; }
  public void setIssuer(String issuer) { this.issuer = issuer; }
  public int getExpirationMinutes() { return expirationMinutes; }
  public void setExpirationMinutes(int expirationMinutes) { this.expirationMinutes = expirationMinutes; }
}
