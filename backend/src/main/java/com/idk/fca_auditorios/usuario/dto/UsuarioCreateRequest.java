package com.idk.fca_auditorios.usuario.dto;

import jakarta.validation.constraints.NotBlank;

public record UsuarioCreateRequest(
    @NotBlank String nombreUsuario,
    String nombre,
    String apellidoPaterno,
    String apellidoMaterno,
    String correo,
    String telefono,
    String celular,
    String rfc,
    /** 'funcionario' | 'administrador' | 'superadministrador' */
    @NotBlank String rol,
    /** Identificador del puesto (recomendado) */
    Integer idPuesto,
    /** Alternativa si prefieres por nombre (se ignora si viene idPuesto) */
    String nombrePuesto,
    /** opcional: si no viene, se usa 'changeme' */
    String contrasenia
) {}
