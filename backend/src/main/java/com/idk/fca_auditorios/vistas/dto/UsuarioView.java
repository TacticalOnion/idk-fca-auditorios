package com.idk.fca_auditorios.vistas.dto;

public interface UsuarioView {
    Integer getIdUsuario();
    String getNombre();
    String getApellidoPaterno();
    String getApellidoMaterno();
    String getNombreUsuario();
    String getCorreo();
    String getTelefono();
    String getCelular();
    Boolean getActivo();
    String getRol();     // rol_usuario.nombre
    String getPuesto();  // puesto.nombre
}
