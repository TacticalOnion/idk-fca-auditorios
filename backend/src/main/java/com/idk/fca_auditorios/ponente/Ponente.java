package com.idk.fca_auditorios.ponente;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name="ponente") @Data
public class Ponente {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name="id_ponente") private Long id;

  private String nombre;
  @Column(name="apellido_paterno") private String apellidoPaterno;
  @Column(name="apellido_materno") private String apellidoMaterno;
  @Column(name="id_pais") private Long idPais;
  private String correo;
  private String telefono;
}
