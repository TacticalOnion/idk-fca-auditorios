package com.idk.fca_auditorios.recinto;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="fotografia") @Data
public class Fotografia {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_fotografia") private Long id;
  @Column(name="id_recinto") private Long idRecinto;
  private String ruta;   // almacenamiento físico
  private Boolean portada;
}
