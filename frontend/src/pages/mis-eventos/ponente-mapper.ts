import type { PonenteFormValue } from '@/pages/mis-eventos/PonentesForm'

export type ReconocimientoBackend = {
  id_semblanza?: number | null
  id_reconocimiento?: number | null
  titulo?: string | null
  organizacion?: string | null
  anio?: number | string | null
  descripcion?: string | null
}

export type ExperienciaBackend = {
  id_semblanza?: number | null
  id_experiencia?: number | null
  puesto?: string | null
  puesto_actual?: boolean | null
  fecha_inicio?: string | null
  fecha_fin?: string | null
  id_empresa?: number | null
  id_pais?: number | null
}

export type GradoBackend = {
  id_semblanza?: number | null
  id_grado?: number | null
  titulo?: string | null
  id_nivel?: number | null
  id_institucion?: number | null
  id_pais?: number | null
}

// Respuesta de /api/ponentes/{id}
export type PonenteFullResponse = {
  ponente: {
    id_ponente: number
    nombre: string
    apellido_paterno: string
    apellido_materno?: string | null
    id_pais?: number | null
  }
  semblanza: { id_semblanza: number; biografia: string }[]
  reconocimientos: ReconocimientoBackend[]
  experiencia: ExperienciaBackend[]
  grados: GradoBackend[]
}

/**
 * Mapper reutilizable: PonenteFullResponse -> PonenteFormValue
 */
export function mapPonenteFullResponseToFormValue(
  data: PonenteFullResponse,
): PonenteFormValue {
  const baseSemblanza =
    Array.isArray(data.semblanza) && data.semblanza.length > 0
      ? data.semblanza[0]
      : null

  return {
    id: data.ponente.id_ponente,
    nombre: data.ponente.nombre,
    apellidoPaterno: data.ponente.apellido_paterno,
    apellidoMaterno: data.ponente.apellido_materno ?? '',
    idPais: data.ponente.id_pais ?? null,
    semblanza: baseSemblanza?.biografia ?? '',
    reconocimientos: (data.reconocimientos || []).map((r) => ({
      idSemblanza: r.id_semblanza ?? baseSemblanza?.id_semblanza ?? null,
      idReconocimiento: r.id_reconocimiento ?? null,
      titulo: r.titulo ?? '',
      organizacion: r.organizacion ?? '',
      anio: r.anio != null ? String(r.anio) : '',
      descripcion: r.descripcion ?? '',
    })),
    experiencia: (data.experiencia || []).map((e) => ({
      idSemblanza: e.id_semblanza ?? baseSemblanza?.id_semblanza ?? null,
      idExperiencia: e.id_experiencia ?? null,
      puesto: e.puesto ?? '',
      puestoActual: Boolean(e.puesto_actual),
      fechaInicio: e.fecha_inicio ?? '',
      fechaFin: e.fecha_fin ?? '',
      idEmpresa: e.id_empresa ?? null,
      idPais: e.id_pais ?? null,
    })),
    grados: (data.grados || []).map((g) => ({
      idSemblanza: g.id_semblanza ?? baseSemblanza?.id_semblanza ?? null,
      idGrado: g.id_grado ?? null,
      titulo: g.titulo ?? '',
      idNivel: g.id_nivel ?? null,
      idInstitucion: g.id_institucion ?? null,
      idPais: g.id_pais ?? null,
    })),
    editable: false,
  }
}
