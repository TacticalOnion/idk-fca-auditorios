package com.idk.fca_auditorios.vistas.dto;

public interface RecintoView {
    Integer getIdRecinto();
    String getNombre();
    String getLatitud();
    String getLongitud();
    Integer getAforo();
    String getCroquis();
    Boolean getActivo();
    String getTipo(); // tipo.nombre
}
