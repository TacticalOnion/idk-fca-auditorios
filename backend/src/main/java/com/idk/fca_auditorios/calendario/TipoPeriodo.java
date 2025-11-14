package com.idk.fca_auditorios.calendario;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "tipo_periodo")
@Data
public class TipoPeriodo {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_tipo_periodo")
  private Long id;

  private String nombre;
}
