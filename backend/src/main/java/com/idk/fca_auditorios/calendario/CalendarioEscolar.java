package com.idk.fca_auditorios.calendario;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity @Table(name="calendario_escolar") @Data
public class CalendarioEscolar {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_calendario_escolar")
  private Long id;
  private String semestre;
  @Column(name="semestre_inicio") private LocalDate semestreInicio;
  @Column(name="semestre_fin") private LocalDate semestreFin;
}
