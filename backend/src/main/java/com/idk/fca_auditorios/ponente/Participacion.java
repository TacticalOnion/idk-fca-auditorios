package com.idk.fca_auditorios.ponente;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "participacion")
@Data
public class Participacion {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_participacion")
  private Long id;

  @Column(name = "id_evento", nullable = false)
  private Long idEvento;

  @Column(name = "id_ponente", nullable = false)
  private Long idPonente;

  // Campos opcionales (descomenta/ajusta si existen en tu esquema)
  // private String rol;                // p.ej. "Conferencista", "Panelista"
  // private String tema;               // tema de la participación
  // @Column(name = "fecha_participacion")
  // private java.time.LocalDate fechaParticipacion;
}
