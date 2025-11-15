package com.idk.fca_auditorios.usuario.dto;

public record UsuarioUpdateRequest(
    String nombre,
    String apellidoPaterno,
    String apellidoMaterno,
    String correo,
    String telefono,
    String celular,
    String rfc,
    Boolean activo,
    // Cambios de rol/puesto opcionales
    String rol,          // por nombre
    Integer idPuesto,    // preferido
    String nombrePuesto  // alternativa por nombre (si no mandas idPuesto)
) {}
