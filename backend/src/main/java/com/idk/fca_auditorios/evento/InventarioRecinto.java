package com.idk.fca_auditorios.evento;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="inventario_recinto") @Data
public class InventarioRecinto {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="numero_registro")
  private Long id;
  @Column(name="id_recinto") private Long idRecinto;
  @Column(name="id_equipamiento") private Long idEquipamiento;
  private Integer cantidad;
  private Boolean activo;
}
