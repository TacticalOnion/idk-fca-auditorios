package com.idk.fca_auditorios.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.lang.NonNull;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

  @Value("${app.uploads.root}")
  private String uploadsRoot;
  @Override
  public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {

    // Ruta absoluta a la carpeta "uploads"
    Path rootPath = Paths.get(uploadsRoot).toAbsolutePath().normalize();

    // Dentro de uploads, la carpeta "recinto" (que contiene fotografias/ y croquis/)
    Path recintoPath = rootPath.resolve("recinto");

    // Ejemplo de resultado:
    // uploadsRoot = src/main/java/com/idk/fca_auditorios/resources/uploads
    // recintoPath = .../resources/uploads/recinto

    registry
        .addResourceHandler("/recinto/**") // lo que se pide por HTTP
        .addResourceLocations("file:" + recintoPath.toString() + "/");
  }
}
