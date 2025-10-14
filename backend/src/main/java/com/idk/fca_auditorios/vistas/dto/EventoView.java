package com.idk.fca_auditorios.vistas.dto;

public interface EventoView {
    Integer getIdEvento();
    String getNombre();
    String getDescripcion();
    String getFechaInicio();
    String getFechaFin();
    String getHorarioInicio();
    String getHorarioFin();
    Boolean getPresencial();
    Boolean getOnline();
    Boolean getMegaEvento();
    String getCategoria();     // categoria.nombre
    String getMegaEventoNombre(); // evento.nombre (id_mega_evento)
}