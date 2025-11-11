package com.idk.fca_auditorios.usuario;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name = "rol_usuario")
@Data
public class RolUsuario {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_rol_usuario")
  private Long id;
  private String nombre;
}
