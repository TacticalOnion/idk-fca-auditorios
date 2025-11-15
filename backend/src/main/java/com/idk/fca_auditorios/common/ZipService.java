package com.idk.fca_auditorios.common;

import org.apache.commons.compress.archivers.zip.*;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.Path;
import java.util.List;

@Service
public class ZipService {

  public Resource zip(String zipFileName, List<Path> files) throws IOException {
    File zipFile = new File(System.getProperty("java.io.tmpdir"), zipFileName);
    try (ZipArchiveOutputStream zaos = new ZipArchiveOutputStream(zipFile)) {
      for (Path p : files) {
        File f = p.toFile();
        if (!f.exists()) continue;
        ZipArchiveEntry entry = new ZipArchiveEntry(f.getName());
        zaos.putArchiveEntry(entry);
        try (InputStream in = new BufferedInputStream(new FileInputStream(f))) {
          in.transferTo(zaos);
        }
        zaos.closeArchiveEntry();
      }
      zaos.finish();
    }
    return new FileSystemResource(zipFile);
  }
}
