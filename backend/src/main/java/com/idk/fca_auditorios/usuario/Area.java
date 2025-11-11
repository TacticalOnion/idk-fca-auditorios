package com.idk.fca_auditorios.usuario;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name = "area")
@Data
class Area {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_area")
  private Long id;
  private String nombre;
}