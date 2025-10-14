package com.idk.fca_auditorios.vistas.dto;

public interface EquipamientoView {
    Integer getIdEquipamiento();
    String getNombre();
    Boolean getActivo();
    String getArea(); // puede ser null
}
