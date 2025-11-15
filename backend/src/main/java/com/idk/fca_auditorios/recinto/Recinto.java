package com.idk.fca_auditorios.recinto;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;

@Entity
@Table(name = "recinto")
@Data
public class Recinto {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_recinto")
  private Long id;

  private String nombre;

  // NUMERIC(9,6)
  private BigDecimal latitud;

  // NUMERIC(9,6)
  private BigDecimal longitud;

  // aforo > 0
  @Column(name = "aforo")
  private Integer aforo;

  // ruta al croquis (ej. "/recinto/croquis/archivo.png")
  private String croquis;

  private Boolean activo = true;

  @Column(name = "id_tipo_recinto")
  private Short idTipoRecinto;
}
