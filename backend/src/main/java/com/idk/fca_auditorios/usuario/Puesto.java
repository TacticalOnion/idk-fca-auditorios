package com.idk.fca_auditorios.usuario;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name = "puesto")
@Data
public class Puesto {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_puesto")
  private Long id;
  private String nombre;

  @ManyToOne @JoinColumn(name = "id_area")
  private Area area;
}
