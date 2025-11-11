package com.idk.fca_auditorios.evento;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="eventoxequipamiento")
@Data
public class EventoxEquipamiento {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_eventoxequipamiento")
  private Long id;

  @Column(name="id_evento") private Long idEvento;
  @Column(name="id_equipamiento") private Long idEquipamiento;
  private Integer cantidad;
}
