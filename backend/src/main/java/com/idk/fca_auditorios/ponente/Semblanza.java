package com.idk.fca_auditorios.ponente;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="semblanza") @Data
public class Semblanza {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_semblanza") private Long id;
  @Column(name="id_ponente") private Long idPonente;
  @Column(name="archivo") private String archivo; // ruta de PDF generado
}
