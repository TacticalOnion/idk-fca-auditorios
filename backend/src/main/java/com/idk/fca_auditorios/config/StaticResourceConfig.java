package com.idk.fca_auditorios.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Paths;

@Configuration
public class StaticResourceConfig implements WebMvcConfigurer {

  /** Raíz donde guardas uploads. Default: src/main/resources/uploads */
  @Value("${app.static.root:src/main/resources/uploads}")
  private String staticRoot;
  @Override
  public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
    // p.ej. /files/usuarios/fotos/foto.png -> file:{project}/src/main/resources/uploads/usuarios/fotos/foto.png
    String fileUri = Paths.get(System.getProperty("user.dir")).resolve(staticRoot).toUri().toString();
    registry.addResourceHandler("/files/**")
        .addResourceLocations(fileUri)
        .setCachePeriod(3600);
  }
}
