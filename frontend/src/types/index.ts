export interface PonenteEvento {
  id: number;
  nombreCompleto: string;
  semblanza: string | null;
  reconocimiento: string | null;
}

export interface OrganizadorEvento {
  nombreCompleto: string;
}

export interface AreaEvento {
  area: string;
}

export interface EquipamientoEvento {
  equipamiento: string;
  cantidad: number;
  disponible?: boolean | null;
  cantidadFaltante?: number | null;
}

export interface Evento {
  id: number;
  nombre: string;
  categoria?: string | null;

  // Info de mega evento
  megaEvento?: boolean | null;          // viene de e.mega_evento (boolean)
  isMegaEvento?: string | null;         // 'Mega Evento' o null
  nombreMegaEvento?: string | null;     // nombre del mega evento (me.nombre)
  recinto?: string | null;

  fechaInicio?: string | null;
  fechaFin?: string | null;
  horarioInicio?: string | null;
  horarioFin?: string | null;

  presencial?: boolean | null;
  online?: boolean | null;
  estatus: string;
  descripcion?: string | null;
  motivo?: string | null;
  fechaRegistro?: string | null;
  numeroRegistro?: string | null;
  calendarioEscolar?: string | null;

  ponentes?: PonenteEvento[] | string | null;
  organizadores?: OrganizadorEvento[] | string | null;
  areas?: AreaEvento[] | string | null;
  equipamiento?: EquipamientoEvento[] | string | null;
}

/** Payload que devuelve GET /api/eventos/{id}/detalle */
export interface DetalleEvento {
  evento: Evento;
  ponentes: PonenteEvento[];
  organizadores?: OrganizadorEvento[];
  areas: AreaEvento[];
  equipamiento: EquipamientoEvento[];
}
