package com.idk.fca_auditorios.evento;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity @Table(name="evento")
@Data
public class Evento {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_evento")
  private Long id;

  private String nombre;

  @Column(name="fecha_inicio") private LocalDate fechaInicio;
  @Column(name="fecha_fin") private LocalDate fechaFin;
  @Column(name="horario_inicio") private LocalTime horarioInicio;
  @Column(name="horario_fin") private LocalTime horarioFin;

  private String estatus; // 'pendiente','autorizado','cancelado' (según UI) :contentReference[oaicite:5]{index=5}
  private Boolean presencial;
  private Boolean online;

  private String descripcion;
  private String motivo;

  @Column(name="mega_evento") private Boolean megaEvento;
  @Column(name="id_mega_evento") private Long idMegaEvento;
  @Column(name="id_categoria") private Long idCategoria;
  @Column(name="id_calendario_escolar") private Long idCalendarioEscolar;
}
