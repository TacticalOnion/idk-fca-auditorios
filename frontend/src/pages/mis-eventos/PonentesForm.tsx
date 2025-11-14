import { useMemo, useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import {
  Button,
  Input,
  Textarea,
  Separator,
  Badge,
} from '@ui/index'
import { api } from '@/lib/api'
import { toast } from 'sonner'

export type ReconocimientoForm = {
  idSemblanza?: number | null
  idReconocimiento?: number | null
  titulo: string
  organizacion: string
  anio: string
  descripcion?: string
}

export type ExperienciaForm = {
  idSemblanza?: number | null
  idExperiencia?: number | null
  puesto: string
  puestoActual: boolean
  fechaInicio: string
  fechaFin: string
  idEmpresa: number | null
  idPais: number | null
}

export type GradoForm = {
  idSemblanza?: number | null
  idGrado?: number | null
  titulo: string
  idNivel: number | null
  idInstitucion: number | null
  idPais: number | null
}

export type PonenteFormValue = {
  id?: number
  nombre: string
  apellidoPaterno: string
  apellidoMaterno: string
  idPais: number | null
  semblanza: string
  reconocimientos: ReconocimientoForm[]
  experiencia: ExperienciaForm[]
  grados: GradoForm[]
  /**
   * Controla si los campos del ponente son editables en el formulario.
   * - Nuevos ponentes -> true
   * - Ponentes importados desde BD -> false (se puede activar con un checkbox)
   */
  editable?: boolean
}

type Option = {
  id: number
  nombre: string
}

// Resultado de /api/ponentes/search
type PonenteSearchItem = {
  id_ponente: number
  nombre: string
  apellido_paterno: string
  apellido_materno?: string | null
  pais?: string | null
}

type ReconocimientoBackend = {
  id_semblanza?: number | null
  id_reconocimiento?: number | null
  titulo?: string | null
  organizacion?: string | null
  anio?: number | string | null
  descripcion?: string | null
}

type ExperienciaBackend = {
  id_semblanza?: number | null
  id_experiencia?: number | null
  puesto?: string | null
  puesto_actual?: boolean | null
  fecha_inicio?: string | null
  fecha_fin?: string | null
  id_empresa?: number | null
  id_pais?: number | null
}

type GradoBackend = {
  id_semblanza?: number | null
  id_grado?: number | null
  titulo?: string | null
  id_nivel?: number | null
  id_institucion?: number | null
  id_pais?: number | null
}

// Respuesta de /api/ponentes/{id}
type PonenteFullResponse = {
  ponente: {
    id_ponente: number
    nombre: string
    apellido_paterno: string
    apellido_materno?: string | null
    id_pais?: number | null
  }
  semblanza: { id_semblanza: number; texto: string }[]
  reconocimientos: ReconocimientoBackend[]
  experiencia: ExperienciaBackend[]
  grados: GradoBackend[]
}

type PonentesFormProps = {
  value: PonenteFormValue[]
  onChange: (next: PonenteFormValue[]) => void
}

export default function PonentesForm({ value, onChange }: PonentesFormProps) {
  const queryClient = useQueryClient()

  // --------------------------------------------------------
  // Catálogos (todos desde /api/catalogos/*)
  // --------------------------------------------------------
  const { data: paises } = useQuery({
    queryKey: ['catalogo-paises'],
    queryFn: async () =>
      (await api.get<Option[]>('/api/catalogos/paises')).data,
  })

  const { data: empresas } = useQuery({
    queryKey: ['catalogo-empresas'],
    queryFn: async () =>
      (await api.get<Option[]>('/api/catalogos/empresas')).data,
  })

  const { data: niveles } = useQuery({
    queryKey: ['catalogo-niveles'],
    queryFn: async () =>
      (await api.get<Option[]>('/api/catalogos/niveles')).data,
  })

  const { data: instituciones } = useQuery({
    queryKey: ['catalogo-instituciones'],
    queryFn: async () =>
      (await api.get<Option[]>('/api/catalogos/instituciones')).data,
  })

  // --------------------------------------------------------
  // Mutaciones para crear empresa / institución nuevas
  // (POST sigue yendo a /api/empresas y /api/instituciones)
  // --------------------------------------------------------
  const crearEmpresa = useMutation({
    mutationFn: async (payload: { nombre: string; idPais: number }) =>
      (await api.post<Option>('/api/empresas', payload)).data,
    onSuccess: () => {
      toast.success('Empresa creada')
      queryClient.invalidateQueries({ queryKey: ['catalogo-empresas'] })
    },
    onError: () => toast.error('No se pudo crear la empresa'),
  })

  const crearInstitucion = useMutation({
    mutationFn: async (payload: { nombre: string; siglas: string }) =>
      (await api.post<Option>('/api/instituciones', payload)).data,
    onSuccess: () => {
      toast.success('Institución creada')
      queryClient.invalidateQueries({ queryKey: ['catalogo-instituciones'] })
    },
    onError: () => toast.error('No se pudo crear la institución'),
  })

  const ponentes = useMemo(() => value || [], [value])

  // --------------------------------------------------------
  // Búsqueda de ponentes existentes
  // --------------------------------------------------------
  const [searchText, setSearchText] = useState('')
  const [searchTerm, setSearchTerm] = useState('')

  const {
    data: searchResults,
    isFetching: searching,
  } = useQuery({
    queryKey: ['buscar-ponentes', searchTerm],
    enabled: searchTerm.trim().length >= 3,
    queryFn: async () => {
      const res = await api.get<PonenteSearchItem[]>('/api/ponentes/search', {
        params: { q: searchTerm.trim() },
      })
      return res.data
    },
  })

  const handleBuscarPonentes = () => {
    if (searchText.trim().length < 3) {
      toast.error('Escribe al menos 3 caracteres para buscar ponentes')
      return
    }
    setSearchTerm(searchText)
  }

  const handleImportarPonente = async (item: PonenteSearchItem) => {
    try {
      const idPonente = item.id_ponente

      // Evitar duplicados por id
      if (ponentes.some((p) => p.id === idPonente)) {
        toast.error('Este ponente ya está agregado al evento')
        return
      }

      const res = await api.get<PonenteFullResponse>(`/api/ponentes/${idPonente}`)
      const data = res.data

      const baseSemblanza =
        Array.isArray(data.semblanza) && data.semblanza.length > 0
          ? data.semblanza[0]
          : null

      const nuevo: PonenteFormValue = {
        id: data.ponente.id_ponente,
        nombre: data.ponente.nombre,
        apellidoPaterno: data.ponente.apellido_paterno,
        apellidoMaterno: data.ponente.apellido_materno ?? '',
        idPais: data.ponente.id_pais ?? null,
        semblanza: baseSemblanza?.texto ?? '',
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
        editable: false, // Importado: por defecto bloqueado
      }

      onChange([...ponentes, nuevo])
      toast.success('Ponente importado al evento')
    } catch (err) {
      console.error(err)
      toast.error('No se pudo importar el ponente')
    }
  }

  // Helpers para manejar arrays
  const addPonente = () => {
    const next: PonenteFormValue[] = [
      ...ponentes,
      {
        nombre: '',
        apellidoPaterno: '',
        apellidoMaterno: '',
        idPais: null,
        semblanza: '',
        reconocimientos: [],
        experiencia: [],
        grados: [],
        editable: true,
      },
    ]
    onChange(next)
  }

  const removePonente = (index: number) => {
    const next = ponentes.filter((_, i) => i !== index)
    onChange(next)
  }

  const updatePonente = (
    index: number,
    partial: Partial<PonenteFormValue>,
  ) => {
    const next = [...ponentes]
    next[index] = { ...next[index], ...partial }
    onChange(next)
  }

  const addReconocimiento = (iPonente: number) => {
    const next = [...ponentes]
    const recs = [...(next[iPonente].reconocimientos || [])]
    recs.push({
      titulo: '',
      organizacion: '',
      anio: '',
      descripcion: '',
    })
    next[iPonente].reconocimientos = recs
    onChange(next)
  }

  const removeReconocimiento = (iPonente: number, iRec: number) => {
    const next = [...ponentes]
    next[iPonente].reconocimientos = next[iPonente].reconocimientos.filter(
      (_, i) => i !== iRec,
    )
    onChange(next)
  }

  const updateReconocimiento = (
    iPonente: number,
    iRec: number,
    partial: Partial<ReconocimientoForm>,
  ) => {
    const next = [...ponentes]
    next[iPonente].reconocimientos[iRec] = {
      ...next[iPonente].reconocimientos[iRec],
      ...partial,
    }
    onChange(next)
  }

  const addExperiencia = (iPonente: number) => {
    const next = [...ponentes]
    const exps = [...(next[iPonente].experiencia || [])]
    exps.push({
      puesto: '',
      puestoActual: false,
      fechaInicio: '',
      fechaFin: '',
      idEmpresa: null,
      idPais: null,
    })
    next[iPonente].experiencia = exps
    onChange(next)
  }

  const removeExperiencia = (iPonente: number, iExp: number) => {
    const next = [...ponentes]
    next[iPonente].experiencia = next[iPonente].experiencia.filter(
      (_, i) => i !== iExp,
    )
    onChange(next)
  }

  const updateExperiencia = (
    iPonente: number,
    iExp: number,
    partial: Partial<ExperienciaForm>,
  ) => {
    const next = [...ponentes]
    next[iPonente].experiencia[iExp] = {
      ...next[iPonente].experiencia[iExp],
      ...partial,
    }
    onChange(next)
  }

  const addGrado = (iPonente: number) => {
    const next = [...ponentes]
    const grados = [...(next[iPonente].grados || [])]
    grados.push({
      titulo: '',
      idNivel: null,
      idInstitucion: null,
      idPais: null,
    })
    next[iPonente].grados = grados
    onChange(next)
  }

  const removeGrado = (iPonente: number, iGrado: number) => {
    const next = [...ponentes]
    next[iPonente].grados = next[iPonente].grados.filter(
      (_, i) => i !== iGrado,
    )
    onChange(next)
  }

  const updateGrado = (
    iPonente: number,
    iGrado: number,
    partial: Partial<GradoForm>,
  ) => {
    const next = [...ponentes]
    next[iPonente].grados[iGrado] = {
      ...next[iPonente].grados[iGrado],
      ...partial,
    }
    onChange(next)
  }

  // Helpers para crear empresa / institución desde el formulario
  const handleCrearEmpresa = async (
    iPonente: number,
    iExp: number,
    nombre: string,
    idPais: number | null,
  ) => {
    if (!nombre || !idPais) {
      toast.error('Nombre de empresa y país son obligatorios')
      return
    }
    const created = await crearEmpresa.mutateAsync({
      nombre,
      idPais,
    })
    updateExperiencia(iPonente, iExp, { idEmpresa: created.id })
  }

  const handleCrearInstitucion = async (
    iPonente: number,
    iGrado: number,
    nombre: string,
    siglas: string,
  ) => {
    if (!nombre || !siglas) {
      toast.error('Nombre y siglas de la institución son obligatorios')
      return
    }
    const created = await crearInstitucion.mutateAsync({
      nombre,
      siglas,
    })
    updateGrado(iPonente, iGrado, { idInstitucion: created.id })
  }

  // --------------------------------------------------------
  // Render
  // --------------------------------------------------------
  return (
    <div className="space-y-4">
      {/* Header principal + botón agregar */}
      <div className="flex items-center justify-between gap-2">
        <h3 className="font-semibold">Ponentes</h3>
        <Button
          type="button"
          size="sm"
          onClick={addPonente}
        >
          Agregar ponente
        </Button>
      </div>
      <Separator />

      {/* 🔍 Búsqueda de ponentes existentes */}
      <section className="space-y-3 rounded-md border border-slate-200 bg-slate-50 p-3">
        <div className="flex items-center justify-between gap-2">
          <div>
            <div className="text-sm font-semibold">Buscar ponentes existentes</div>
            <p className="text-[11px] text-slate-500">
              Reutiliza ponentes ya registrados. Escribe al menos 3 caracteres y
              luego haz clic en &quot;Buscar&quot;.
            </p>
          </div>
        </div>

        <div className="flex flex-col gap-2 md:flex-row">
          <Input
            placeholder="Buscar por nombre o apellidos..."
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
          />
          <Button
            type="button"
            onClick={handleBuscarPonentes}
            disabled={searching}
          >
            {searching ? 'Buscando...' : 'Buscar'}
          </Button>
        </div>

        {searchTerm && (
          <div className="mt-2 space-y-1 max-h-52 overflow-y-auto">
            {searching && (
              <p className="text-xs text-slate-500">Buscando ponentes...</p>
            )}
            {!searching && (searchResults || []).length === 0 && (
              <p className="text-xs text-slate-500">
                No se encontraron ponentes para &quot;{searchTerm}&quot;.
              </p>
            )}
            {(searchResults || []).map((item) => (
              <div
                key={item.id_ponente}
                className="flex items-center justify-between gap-2 rounded-md border border-slate-200 bg-white px-2 py-1"
              >
                <div className="text-xs">
                  <div className="font-medium">
                    {item.nombre} {item.apellido_paterno} {item.apellido_materno}
                  </div>
                  {item.pais && (
                    <div className="text-[11px] text-slate-500">
                      País: {item.pais}
                    </div>
                  )}
                </div>
                <Button
                  type="button"
                  size="sm"
                  variant="outline"
                  onClick={() => handleImportarPonente(item)}
                >
                  Importar
                </Button>
              </div>
            ))}
          </div>
        )}
      </section>

      {ponentes.length === 0 && (
        <p className="text-xs text-slate-500">
          Aún no has agregado ponentes. Puedes crearlos manualmente o importarlos
          desde los existentes.
        </p>
      )}

      {ponentes.map((p, iPonente) => (
        <div
          key={iPonente}
          className="rounded-md border border-slate-200 p-3 space-y-3"
        >
          <div className="flex items-center justify-between gap-2">
            <div className="text-sm font-semibold">
              Ponente {iPonente + 1}{' '}
              {p.nombre && (
                <span className="font-normal text-slate-600">
                  - {p.nombre} {p.apellidoPaterno} {p.apellidoMaterno}
                </span>
              )}
            </div>
            <div className="flex items-center gap-2">
              {p.id && (
                <Badge variant="outline" className="text-[11px]">
                  Importado
                </Badge>
              )}
              <label className="flex items-center gap-1 text-[11px] text-slate-600">
                <input
                  type="checkbox"
                  checked={p.editable ?? !p.id}
                  onChange={(e) =>
                    updatePonente(iPonente, { editable: e.target.checked })
                  }
                />
                Editable
              </label>
              <Button
                type="button"
                variant="outline"
                onClick={() => removePonente(iPonente)}
              >
                Quitar
              </Button>
            </div>
          </div>

          {/* Datos básicos del ponente */}
          <div className="grid md:grid-cols-3 gap-2">
            <div>
              <label className="block text-xs font-medium">Nombre</label>
              <Input
                value={p.nombre}
                disabled={p.editable === false}
                onChange={(e) =>
                  updatePonente(iPonente, { nombre: e.target.value })
                }
              />
            </div>
            <div>
              <label className="block text-xs font-medium">
                Apellido paterno
              </label>
              <Input
                value={p.apellidoPaterno}
                disabled={p.editable === false}
                onChange={(e) =>
                  updatePonente(iPonente, { apellidoPaterno: e.target.value })
                }
              />
            </div>
            <div>
              <label className="block text-xs font-medium">
                Apellido materno
              </label>
              <Input
                value={p.apellidoMaterno}
                disabled={p.editable === false}
                onChange={(e) =>
                  updatePonente(iPonente, { apellidoMaterno: e.target.value })
                }
              />
            </div>
          </div>

          <div className="grid md:grid-cols-2 gap-2">
            <div>
              <label className="block text-xs font-medium">País</label>
              <select
                className="border rounded-md px-2 py-1 text-xs w-full"
                value={p.idPais ?? ''}
                disabled={p.editable === false}
                onChange={(e) =>
                  updatePonente(iPonente, {
                    idPais: e.target.value ? Number(e.target.value) : null,
                  })
                }
              >
                <option value="">Selecciona un país</option>
                {(paises || []).map((pais) => (
                  <option key={pais.id} value={pais.id}>
                    {pais.nombre}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <div>
            <label className="block text-xs font-medium">Semblanza</label>
            <Textarea
              value={p.semblanza}
              disabled={p.editable === false}
              onChange={(e) =>
                updatePonente(iPonente, { semblanza: e.target.value })
              }
              className="text-xs"
            />
          </div>

          {/* Reconocimientos */}
          <div className="space-y-2">
            <div className="flex items-center justify-between gap-2">
              <div className="text-xs font-semibold">Reconocimientos</div>
              <Button
                type="button"
                variant="outline"
                disabled={p.editable === false}
                onClick={() => addReconocimiento(iPonente)}
              >
                Agregar reconocimiento
              </Button>
            </div>
            {(p.reconocimientos || []).length === 0 && (
              <p className="text-[11px] text-slate-500">
                Sin reconocimientos capturados.
              </p>
            )}
            {(p.reconocimientos || []).map((r, iRec) => (
              <div
                key={iRec}
                className="grid md:grid-cols-4 gap-2 rounded-md border border-slate-200 p-2"
              >
                <div className="md:col-span-2">
                  <label className="block text-[11px] font-medium">
                    Título
                  </label>
                  <Input
                    value={r.titulo}
                    disabled={p.editable === false}
                    onChange={(e) =>
                      updateReconocimiento(iPonente, iRec, {
                        titulo: e.target.value,
                      })
                    }
                  />
                </div>
                <div>
                  <label className="block text-[11px] font-medium">
                    Organización
                  </label>
                  <Input
                    value={r.organizacion}
                    disabled={p.editable === false}
                    onChange={(e) =>
                      updateReconocimiento(iPonente, iRec, {
                        organizacion: e.target.value,
                      })
                    }
                  />
                </div>
                <div>
                  <label className="block text-[11px] font-medium">Año</label>
                  <Input
                    value={r.anio}
                    disabled={p.editable === false}
                    onChange={(e) =>
                      updateReconocimiento(iPonente, iRec, {
                        anio: e.target.value,
                      })
                    }
                  />
                </div>
                <div className="md:col-span-3">
                  <label className="block text-[11px] font-medium">
                    Descripción (opcional)
                  </label>
                  <Textarea
                    value={r.descripcion ?? ''}
                    disabled={p.editable === false}
                    onChange={(e) =>
                      updateReconocimiento(iPonente, iRec, {
                        descripcion: e.target.value,
                      })
                    }
                    className="text-xs"
                  />
                </div>
                <div className="flex items-center justify-end">
                  <Button
                    type="button"
                    variant="outline"
                    disabled={p.editable === false}
                    onClick={() => removeReconocimiento(iPonente, iRec)}
                  >
                    Quitar
                  </Button>
                </div>
              </div>
            ))}
          </div>

          {/* Experiencia */}
          <div className="space-y-2">
            <div className="flex items-center justify-between gap-2">
              <div className="text-xs font-semibold">Experiencia</div>
              <Button
                type="button"
                variant="outline"
                disabled={p.editable === false}
                onClick={() => addExperiencia(iPonente)}
              >
                Agregar experiencia
              </Button>
            </div>

            {(p.experiencia || []).length === 0 && (
              <p className="text-[11px] text-slate-500">
                Sin experiencia registrada.
              </p>
            )}

            {(p.experiencia || []).map((exp, iExp) => (
              <div
                key={iExp}
                className="space-y-2 rounded-md border border-slate-200 p-2"
              >
                <div className="grid md:grid-cols-3 gap-2">
                  <div>
                    <label className="block text-[11px] font-medium">
                      Puesto
                    </label>
                    <Input
                      value={exp.puesto}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateExperiencia(iPonente, iExp, {
                          puesto: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="block text-[11px] font-medium">
                      Empresa
                    </label>
                    <select
                      className="border rounded-md px-2 py-1 text-xs w-full"
                      value={exp.idEmpresa ?? ''}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateExperiencia(iPonente, iExp, {
                          idEmpresa: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">Selecciona una empresa</option>
                      {(empresas || []).map((emp) => (
                        <option key={emp.id} value={emp.id}>
                          {emp.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="block text-[11px] font-medium">País</label>
                    <select
                      className="border rounded-md px-2 py-1 text-xs w-full"
                      value={exp.idPais ?? ''}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateExperiencia(iPonente, iExp, {
                          idPais: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">Selecciona un país</option>
                      {(paises || []).map((pais) => (
                        <option key={pais.id} value={pais.id}>
                          {pais.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                </div>

                <div className="grid md:grid-cols-3 gap-2 items-end">
                  <div>
                    <label className="block text-[11px] font-medium">
                      Fecha inicio
                    </label>
                    <Input
                      type="date"
                      value={exp.fechaInicio}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateExperiencia(iPonente, iExp, {
                          fechaInicio: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="block text-[11px] font-medium">
                      Fecha fin
                    </label>
                    <Input
                      type="date"
                      value={exp.fechaFin}
                      disabled={p.editable === false || exp.puestoActual}
                      onChange={(e) =>
                        updateExperiencia(iPonente, iExp, {
                          fechaFin: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div className="flex items-center gap-2">
                    <label className="flex items-center gap-1 text-[11px]">
                      <input
                        type="checkbox"
                        checked={exp.puestoActual}
                        disabled={p.editable === false}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            puestoActual: e.target.checked,
                          })
                        }
                      />
                      Puesto actual
                    </label>
                  </div>
                </div>

                {/* Atajo para crear empresa rápida */}
                <div className="grid md:grid-cols-2 gap-2">
                  <div>
                    <label className="block text-[11px] font-medium">
                      Crear nueva empresa (rápido)
                    </label>
                    <div className="flex gap-1">
                      <Input
                        placeholder="Nombre de la empresa"
                        disabled={p.editable === false}
                        onBlur={async (e) => {
                          const nombre = e.target.value.trim()
                          if (!nombre) return
                          if (!exp.idPais) {
                            toast.error(
                              'Selecciona un país en la experiencia antes de crear empresa',
                            )
                            return
                          }
                          await handleCrearEmpresa(
                            iPonente,
                            iExp,
                            nombre,
                            exp.idPais,
                          )
                          e.target.value = ''
                        }}
                      />
                    </div>
                    <p className="text-[10px] text-slate-500">
                      Escribe el nombre y cambia el foco para crear la empresa y asignarla.
                    </p>
                  </div>
                  <div className="flex items-end justify-end">
                    <Button
                      type="button"
                      variant="outline"
                      disabled={p.editable === false}
                      onClick={() => removeExperiencia(iPonente, iExp)}
                    >
                      Quitar experiencia
                    </Button>
                  </div>
                </div>
              </div>
            ))}
          </div>

          {/* Grados académicos */}
          <div className="space-y-2">
            <div className="flex items-center justify-between gap-2">
              <div className="text-xs font-semibold">Grados académicos</div>
              <Button
                type="button"
                variant="outline"
                disabled={p.editable === false}
                onClick={() => addGrado(iPonente)}
              >
                Agregar grado
              </Button>
            </div>

            {(p.grados || []).length === 0 && (
              <p className="text-[11px] text-slate-500">
                Sin grados registrados.
              </p>
            )}

            {(p.grados || []).map((g, iGrado) => (
              <div
                key={iGrado}
                className="space-y-2 rounded-md border border-slate-200 p-2"
              >
                <div className="grid md:grid-cols-2 gap-2">
                  <div>
                    <label className="block text-[11px] font-medium">
                      Título del grado
                    </label>
                    <Input
                      value={g.titulo}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          titulo: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="block text-[11px] font-medium">
                      Nivel
                    </label>
                    <select
                      className="border rounded-md px-2 py-1 text-xs w-full"
                      value={g.idNivel ?? ''}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          idNivel: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">Selecciona un nivel</option>
                      {(niveles || []).map((n) => (
                        <option key={n.id} value={n.id}>
                          {n.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                </div>

                <div className="grid md:grid-cols-3 gap-2">
                  <div>
                    <label className="block text-[11px] font-medium">
                      Institución
                    </label>
                    <select
                      className="border rounded-md px-2 py-1 text-xs w-full"
                      value={g.idInstitucion ?? ''}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          idInstitucion: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">Selecciona una institución</option>
                      {(instituciones || []).map((inst) => (
                        <option key={inst.id} value={inst.id}>
                          {inst.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="block text-[11px] font-medium">
                      País
                    </label>
                    <select
                      className="border rounded-md px-2 py-1 text-xs w-full"
                      value={g.idPais ?? ''}
                      disabled={p.editable === false}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          idPais: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">Selecciona un país</option>
                      {(paises || []).map((pais) => (
                        <option key={pais.id} value={pais.id}>
                          {pais.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="flex items-end justify-end">
                    <Button
                      type="button"
                      variant="outline"
                      disabled={p.editable === false}
                      onClick={() => removeGrado(iPonente, iGrado)}
                    >
                      Quitar grado
                    </Button>
                  </div>
                </div>

                {/* Atajo para crear institución rápida */}
                <div>
                  <label className="block text-[11px] font-medium">
                    Crear nueva institución (rápido)
                  </label>
                  <div className="flex gap-1">
                    <Input
                      placeholder="Nombre de la institución"
                      disabled={p.editable === false}
                      onBlur={async (e) => {
                        const nombre = e.target.value.trim()
                        if (!nombre) return
                        const siglas = nombre
                          .split(' ')
                          .map((part) => part[0])
                          .join('')
                          .toUpperCase()
                          .slice(0, 10)
                        await handleCrearInstitucion(
                          iPonente,
                          iGrado,
                          nombre,
                          siglas,
                        )
                        e.target.value = ''
                      }}
                    />
                  </div>
                  <p className="text-[10px] text-slate-500">
                    Escribe el nombre y cambia el foco para crear la institución y asignarla.
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}
