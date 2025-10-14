package com.idk.fca_auditorios.vistas.dto;

public interface EventoOrganizadorView {
    String getEvento();       // evento.nombre
    String getOrganizador();  // usuario: nombre completo
    Boolean getConfirmacion();
    Integer getNumeroRegistro();
}
