package com.idk.fca_auditorios.evento;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="reservacion") @Data
public class Reservacion {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_reservacion")
  private Long id;
  @Column(name="id_evento") private Long idEvento;
  @Column(name="id_recinto") private Long idRecinto;
}
