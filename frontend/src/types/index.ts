export type Evento = {
  id: number
  nombre: string
  estatus: 'pendiente' | 'autorizado' | 'cancelado'
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
}

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

// Detalle de evento
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
