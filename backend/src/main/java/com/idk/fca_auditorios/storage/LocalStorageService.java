package com.idk.fca_auditorios.storage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.*;

@Service
public class LocalStorageService {
  @Value("${app.uploads.usuarios}")        private String dirUsuarios;
  @Value("${app.uploads.semblanzas}")      private String dirSemblanzas;
  @Value("${app.uploads.reconocimientos}") private String dirReconocimientos;
  @Value("${app.uploads.equipamiento}")    private String dirEquipamiento;
  @Value("${app.uploads.fotografias}")     private String dirFotografias;

  public Path resolveSemblanza(String fileName) { return Paths.get(dirSemblanzas, fileName); }
  public Path resolveReconocimiento(String fileName) { return Paths.get(dirReconocimientos, fileName); }

  public void ensureDirs() {
    for (String d : new String[]{dirUsuarios, dirSemblanzas, dirReconocimientos, dirEquipamiento, dirFotografias}) {
      try { Files.createDirectories(Paths.get(d)); } catch (IOException ignored) {}
    }
  }
}
