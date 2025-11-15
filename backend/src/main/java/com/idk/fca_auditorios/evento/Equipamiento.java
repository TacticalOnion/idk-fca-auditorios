package com.idk.fca_auditorios.evento;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="equipamiento") @Data
public class Equipamiento {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_equipamiento")
  private Long id;
  private String nombre;
  private Boolean existencia;
}