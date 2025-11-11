package com.idk.fca_auditorios.evento.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record EventoCreateRequest(
    @NotBlank String nombre,
    String descripcion,
    @NotNull String fechaInicio,  // ISO yyyy-MM-dd
    @NotNull String fechaFin,     // ISO
    @NotNull String horarioInicio, // HH:mm
    @NotNull String horarioFin,    // HH:mm
    Boolean presencial,
    Boolean online
) {}
