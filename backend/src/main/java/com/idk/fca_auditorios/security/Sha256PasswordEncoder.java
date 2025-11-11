package com.idk.fca_auditorios.security;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HexFormat;

@Component
public class Sha256PasswordEncoder implements PasswordEncoder {
  private static final HexFormat HEX = HexFormat.of();

  @Override
  public String encode(CharSequence rawPassword) {
    return sha256(rawPassword.toString());
  }

  @Override
  public boolean matches(CharSequence rawPassword, String encodedPassword) {
    if (encodedPassword == null) return false;
    String stored = stripUnicodeWhitespace(encodedPassword);
    String calc = sha256(rawPassword.toString());
    return calc.equalsIgnoreCase(stored);
  }

  private String sha256(String input) {
    try {
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      byte[] digest = md.digest(input.getBytes(StandardCharsets.UTF_8));
      return HEX.formatHex(digest);
    } catch (Exception e) {
      throw new IllegalStateException("SHA-256 not available", e);
    }
  }

  private String stripUnicodeWhitespace(String s) {
    int i = 0, j = s.length();
    while (i < j && Character.isWhitespace(s.charAt(i))) i++;
    while (j > i && Character.isWhitespace(s.charAt(j - 1))) j--;
    return s.substring(i, j);
  }
}
