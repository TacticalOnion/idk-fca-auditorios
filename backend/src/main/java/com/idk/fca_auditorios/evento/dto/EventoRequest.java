package com.idk.fca_auditorios.evento.dto;

import java.util.List;

public class EventoRequest {
    public String nombre;
    public Integer idCategoria;
    public Integer idMegaEvento;
    public boolean isMegaEvento;
    public Integer idRecinto;
    public String fechaInicio;
    public String fechaFin;
    public String horarioInicio;
    public String horarioFin;
    public boolean presencial;
    public boolean online;
    public String estatus;
    public String descripcion;

    public List<OrganizadorDTO> organizadores;
    public List<EquipamientoDTO> equipamiento;
    public List<PonenteDTO> ponentes;

    public static class OrganizadorDTO {
        public Integer idUsuario;
    }

    public static class EquipamientoDTO {
        public Integer idEquipamiento;
        public Integer cantidad;
    }

    public static class PonenteDTO {
        public Integer id;
        public String nombre;
        public String apellidoPaterno;
        public String apellidoMaterno;
        public Integer idPais;
        public String semblanza;

        public List<ReconocimientoDTO> reconocimientos;
        public List<ExperienciaDTO> experiencia;
        public List<GradoDTO> grados;
    }

    public static class ReconocimientoDTO {
        public Integer idSemblanza;
        public Integer idReconocimiento;
        public String titulo;
        public String organizacion;
        public Integer anio;
        public String descripcion;
    }

    public static class ExperienciaDTO {
        public Integer idSemblanza;
        public Integer idExperiencia;
        public String puesto;
        public boolean puestoActual;
        public String fechaInicio;
        public String fechaFin;
        public Integer idEmpresa;
        public Integer idPais;
    }

    public static class GradoDTO {
        public Integer idSemblanza;
        public Integer idGrado;
        public String titulo;
        public Integer idNivel;
        public Integer idInstitucion;
        public Integer idPais;
    }
}
