package com.idk.fca_auditorios.vistas.dto;

public interface AuditoriaView {
    Long getIdAuditoria();
    String getNombreTabla();
    Integer getIdRegistroAfectado();
    String getAccion();
    String getCampoModificado();
    String getValorAnterior();
    String getValorNuevo();
    String getUsuario();     // nombre completo desde usuario
    String getFechaHora();   // timestamp como texto
}
