package com.idk.fca_auditorios.recinto;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="recinto") @Data
public class Recinto {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_recinto") private Long id;

  private String nombre;
  private Integer capacidad;
  private String ubicacion;  // ej. edificio, planta
  private String croquis;    // ruta a archivo croquis (si aplica)
  private Boolean activo;
}
