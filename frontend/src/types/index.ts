export type PonenteEvento = {
  nombreCompleto: string
  semblanza?: string | null
  reconocimiento?: string | null
}

export type OrganizadorEvento = {
  nombreCompleto: string
}

export type AreaEvento = {
  area: string
}

export type EquipamientoEvento = {
  equipamiento: string
  cantidad: number
}

export type Evento = {
  id: number
  nombre: string
  estatus: 'pendiente' | 'autorizado' | 'cancelado' | 'realizado'
  descripcion?: string
  motivo?: string
  fechaInicio?: string
  fechaFin?: string
  horarioInicio?: string
  horarioFin?: string
  presencial?: boolean
  online?: boolean
  numeroRegistro?: number | null
  megaEvento?: boolean
  idMegaEvento?: number
  idCategoria?: number
  idCalendarioEscolar?: number

  // extras para TableView
  fechaRegistro?: string
  categoria?: string | null
  nombreMegaEvento?: string | null    // nombre del mega evento (si aplica)
  isMegaEvento?: string | null        // 'Mega Evento' o null
  recinto?: string | null
  calendarioEscolar?: string | null

  ponentes?: PonenteEvento[]
  organizadores?: OrganizadorEvento[]
  areas?: AreaEvento[]
  equipamiento?: EquipamientoEvento[]
}

// (deja el resto de tipos que ya tienes)
export type Calendario = {
  id: number
  semestre: string
  semestreInicio: string
  semestreFin: string
  periodos: Periodo[]
}

export type Periodo = {
  id: number
  idTipoPeriodo: number
  fechaInicio: string
  fechaFin: string
}

export type DetalleEvento = {
  evento: Record<string, unknown>
  organizadores: Organizador[]
  recintos: RecintoDet[]
  equipamiento: EquipamientoDet[]
  areas: AreaDet[]
}

export type Organizador = {
  id: number
  username: string
  nombre?: string
  apellidoPaterno?: string
  apellidoMaterno?: string
  correo?: string
}

export type RecintoDet = {
  id: number
  nombre: string
  aforo?: number
  croquis?: string | null
}

export type EquipamientoDet = {
  id: number
  nombre: string
  solicitado: number
  disponible: number
  faltante: number
}

export type AreaDet = {
  id: number
  nombre: string
}
