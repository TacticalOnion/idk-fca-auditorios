package com.idk.fca_auditorios.usuario;

import jakarta.persistence.*;
import lombok.Data;

@Entity @Table(name = "usuario")
@Data
public class Usuario {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_usuario")
  private Long id;

  @Column(name = "nombre_usuario", nullable = false, unique = true)
  private String nombreUsuario;

  @Column(name = "contrasenia", nullable = false, length = 64)
  private String contrasenia; // SHA-256 hex (64) :contentReference[oaicite:3]{index=3}

  private String nombre;
  @Column(name = "apellido_paterno") private String apellidoPaterno;
  @Column(name = "apellido_materno") private String apellidoMaterno;
  private String rfc;
  private String telefono;
  private String celular;
  private String correo;
  private Boolean activo;

  @ManyToOne @JoinColumn(name = "id_puesto")
  private Puesto puesto;

  @ManyToOne @JoinColumn(name = "id_rol_usuario")
  private RolUsuario rol;
}
