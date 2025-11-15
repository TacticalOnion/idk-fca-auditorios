package com.idk.fca_auditorios.calendario;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity @Table(name="periodo") @Data
public class Periodo {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_periodo")
  private Long id;
  @Column(name="id_calendario_escolar") private Long idCalendarioEscolar;
  @Column(name="id_tipo_periodo") private Long idTipoPeriodo;
  @Column(name="fecha_inicio") private LocalDate fechaInicio;
  @Column(name="fecha_fin") private LocalDate fechaFin;
}
