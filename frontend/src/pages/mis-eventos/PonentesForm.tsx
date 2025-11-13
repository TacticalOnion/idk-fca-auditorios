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
}

type Option = {
  id: number
  nombre: string
}

type PonentesFormProps = {
  value: PonenteFormValue[]
  onChange: (next: PonenteFormValue[]) => void
}

export default function PonentesForm({ value, onChange }: PonentesFormProps) {
  const queryClient = useQueryClient()

  // Catálogos
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

  // Mutaciones para crear empresa / institución nuevas
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

  // Helpers inmutables
  const updatePonente = (index: number, patch: Partial<PonenteFormValue>) => {
    const next = [...ponentes]
    next[index] = { ...next[index], ...patch }
    onChange(next)
  }

  const updateReconocimiento = (
    iPonente: number,
    iRec: number,
    patch: Partial<ReconocimientoForm>,
  ) => {
    const next = [...ponentes]
    const recs = [...(next[iPonente].reconocimientos || [])]
    recs[iRec] = { ...recs[iRec], ...patch }
    next[iPonente].reconocimientos = recs
    onChange(next)
  }

  const updateExperiencia = (
    iPonente: number,
    iExp: number,
    patch: Partial<ExperienciaForm>,
  ) => {
    const next = [...ponentes]
    const exps = [...(next[iPonente].experiencia || [])]

    // Regla: solo un puestoActual = true por ponente
    if (patch.puestoActual === true) {
      const updatedExps = exps.map((exp, idx) => ({
        ...exp,
        puestoActual: idx === iExp,
        // si es el actual, no permitimos editar fechaFin (backend pondrá la fecha actual)
        fechaFin: idx === iExp ? '' : exp.fechaFin,
      }))
      next[iPonente].experiencia = updatedExps
    } else {
      exps[iExp] = { ...exps[iExp], ...patch }
      next[iPonente].experiencia = exps
    }

    onChange(next)
  }

  const updateGrado = (
    iPonente: number,
    iGrado: number,
    patch: Partial<GradoForm>,
  ) => {
    const next = [...ponentes]
    const grados = [...(next[iPonente].grados || [])]
    grados[iGrado] = { ...grados[iGrado], ...patch }
    next[iPonente].grados = grados
    onChange(next)
  }

  // Add/remove
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
      },
    ]
    onChange(next)
  }

  const removePonente = (index: number) => {
    const next = ponentes.filter((_, i) => i !== index)
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

  // Helpers para forms rápidos de empresa / institución
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

  return (
    <div className="space-y-4">
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

      {ponentes.length === 0 && (
        <p className="text-xs text-slate-500">
          Aún no has agregado ponentes. Usa el botón &quot;Agregar ponente&quot;.
        </p>
      )}

      {ponentes.map((p, iPonente) => (
        <div
          key={iPonente}
          className="rounded-lg border border-slate-200 p-4 space-y-4"
        >
          {/* Header ponente */}
          <div className="flex items-start justify-between gap-4">
            <div className="space-y-2 flex-1">
              <div className="grid md:grid-cols-3 gap-3">
                <div>
                  <label className="block text-xs font-medium">
                    Nombre
                  </label>
                  <Input
                    value={p.nombre}
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
                    onChange={(e) =>
                      updatePonente(iPonente, {
                        apellidoPaterno: e.target.value,
                      })
                    }
                  />
                </div>
                <div>
                  <label className="block text-xs font-medium">
                    Apellido materno
                  </label>
                  <Input
                    value={p.apellidoMaterno}
                    onChange={(e) =>
                      updatePonente(iPonente, {
                        apellidoMaterno: e.target.value,
                      })
                    }
                  />
                </div>
              </div>

              <div className="grid md:grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-medium">
                    País del ponente
                  </label>
                  <select
                    className="border rounded-md px-2 py-2 w-full text-sm"
                    value={p.idPais ?? ''}
                    onChange={(e) =>
                      updatePonente(iPonente, {
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
            </div>

            <div className="flex flex-col items-end gap-2">
              <Badge variant="outline">
                Ponente #{iPonente + 1}
              </Badge>
              <Button
                type="button"
                size="icon"
                variant="ghost"
                onClick={() => removePonente(iPonente)}
              >
                ✕
              </Button>
            </div>
          </div>

          {/* Semblanza */}
          <div className="space-y-2">
            <label className="block text-xs font-medium">
              Semblanza
            </label>
            <Textarea
              className="min-h-20"
              value={p.semblanza}
              onChange={(e) =>
                updatePonente(iPonente, { semblanza: e.target.value })
              }
              placeholder="Resumen profesional y biográfico del ponente..."
            />
            <p className="text-[11px] text-slate-500">
              A partir de esta semblanza, el backend puede generar o asociar
              la <code>idSemblanza</code> y relacionarla con reconocimientos,
              experiencia y grados.
            </p>
          </div>

          <Separator />

          {/* Reconocimientos */}
          <section className="space-y-3">
            <div className="flex items-center justify-between gap-2">
              <h4 className="text-sm font-semibold">Reconocimientos</h4>
              <Button
                type="button"
                size="sm"
                variant="outline"
                onClick={() => addReconocimiento(iPonente)}
              >
                Agregar reconocimiento
              </Button>
            </div>

            {p.reconocimientos.length === 0 && (
              <p className="text-[11px] text-slate-500">
                No hay reconocimientos agregados.
              </p>
            )}

            {p.reconocimientos.map((rec, iRec) => (
              <div
                key={iRec}
                className="rounded-md border border-slate-200 p-3 space-y-2"
              >
                <div className="flex justify-between items-center">
                  <span className="text-xs font-medium">
                    Reconocimiento #{iRec + 1}
                  </span>
                  <Button
                    type="button"
                    size="icon"
                    variant="ghost"
                    onClick={() =>
                      removeReconocimiento(iPonente, iRec)
                    }
                  >
                    ✕
                  </Button>
                </div>

                <div className="grid md:grid-cols-3 gap-3">
                  <div>
                    <label className="block text-xs font-medium">
                      Título
                    </label>
                    <Input
                      value={rec.titulo}
                      onChange={(e) =>
                        updateReconocimiento(iPonente, iRec, {
                          titulo: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="block text-xs font-medium">
                      Organización
                    </label>
                    <Input
                      value={rec.organizacion}
                      onChange={(e) =>
                        updateReconocimiento(iPonente, iRec, {
                          organizacion: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="block text-xs font-medium">
                      Año
                    </label>
                    <Input
                      type="number"
                      value={rec.anio}
                      onChange={(e) =>
                        updateReconocimiento(iPonente, iRec, {
                          anio: e.target.value,
                        })
                      }
                    />
                  </div>
                </div>

                <div>
                  <label className="block text-xs font-medium">
                    Descripción (opcional)
                  </label>
                  <Textarea
                    className="min-h-16"
                    value={rec.descripcion ?? ''}
                    onChange={(e) =>
                      updateReconocimiento(iPonente, iRec, {
                        descripcion: e.target.value,
                      })
                    }
                  />
                </div>
              </div>
            ))}
          </section>

          <Separator />

          {/* Experiencia */}
          <section className="space-y-3">
            <div className="flex items-center justify-between gap-2">
              <h4 className="text-sm font-semibold">Experiencia</h4>
              <Button
                type="button"
                size="sm"
                variant="outline"
                onClick={() => addExperiencia(iPonente)}
              >
                Agregar experiencia
              </Button>
            </div>

            {p.experiencia.length === 0 && (
              <p className="text-[11px] text-slate-500">
                No hay experiencias agregadas.
              </p>
            )}

            {p.experiencia.map((exp, iExp) => {
              const esActual = Boolean(exp.puestoActual)

              return (
                <div
                  key={iExp}
                  className="rounded-md border border-slate-200 p-3 space-y-3"
                >
                  <div className="flex justify-between items-center">
                    <span className="text-xs font-medium">
                      Experiencia #{iExp + 1}{' '}
                      {esActual && (
                        <Badge
                          variant="secondary"
                          className="ml-1"
                        >
                          Puesto actual
                        </Badge>
                      )}
                    </span>
                    <Button
                      type="button"
                      size="icon"
                      variant="ghost"
                      onClick={() =>
                        removeExperiencia(iPonente, iExp)
                      }
                    >
                      ✕
                    </Button>
                  </div>

                  <div className="grid md:grid-cols-3 gap-3">
                    <div>
                      <label className="block text-xs font-medium">
                        Puesto
                      </label>
                      <Input
                        value={exp.puesto}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            puesto: e.target.value,
                          })
                        }
                      />
                    </div>

                    <div className="flex items-center gap-2 mt-6">
                      <input
                        id={`puesto-actual-${iPonente}-${iExp}`}
                        type="checkbox"
                        checked={esActual}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            puestoActual: e.target.checked,
                          })
                        }
                      />
                      <label
                        htmlFor={`puesto-actual-${iPonente}-${iExp}`}
                        className="text-xs"
                      >
                        Puesto actual
                      </label>
                    </div>
                  </div>

                  <div className="grid md:grid-cols-3 gap-3">
                    <div>
                      <label className="block text-xs font-medium">
                        Fecha inicio
                      </label>
                      <Input
                        type="date"
                        value={exp.fechaInicio}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            fechaInicio: e.target.value,
                          })
                        }
                      />
                    </div>
                    <div>
                      <label className="block text-xs font-medium">
                        Fecha fin
                      </label>
                      <Input
                        type="date"
                        disabled={esActual}
                        value={exp.fechaFin}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            fechaFin: e.target.value,
                          })
                        }
                      />
                      {esActual && (
                        <p className="text-[10px] text-slate-500">
                          Para el puesto actual, la fecha fin la
                          establecerá el sistema automáticamente.
                        </p>
                      )}
                    </div>
                    <div>
                      <label className="block text-xs font-medium">
                        País de la empresa
                      </label>
                      <select
                        className="border rounded-md px-2 py-2 w-full text-sm"
                        value={exp.idPais ?? ''}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            idPais: e.target.value
                              ? Number(e.target.value)
                              : null,
                          })
                        }
                      >
                        <option value="">
                          Selecciona un país
                        </option>
                        {(paises || []).map((pais) => (
                          <option
                            key={pais.id}
                            value={pais.id}
                          >
                            {pais.nombre}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>

                  {/* Empresa: select + opción de crear */}
                  <div className="grid md:grid-cols-[2fr_1fr] gap-3 items-end">
                    <div>
                      <label className="block text-xs font-medium">
                        Empresa
                      </label>
                      <select
                        className="border rounded-md px-2 py-2 w-full text-sm"
                        value={exp.idEmpresa ?? ''}
                        onChange={(e) =>
                          updateExperiencia(iPonente, iExp, {
                            idEmpresa: e.target.value
                              ? Number(e.target.value)
                              : null,
                          })
                        }
                      >
                        <option value="">
                          Selecciona una empresa
                        </option>
                        {(empresas || []).map((emp) => (
                          <option
                            key={emp.id}
                            value={emp.id}
                          >
                            {emp.nombre}
                          </option>
                        ))}
                      </select>
                    </div>

                    {/* Form rápido para nueva empresa */}
                    <NuevaEmpresaInline
                      onCrear={(nombre, idPais) =>
                        handleCrearEmpresa(
                          iPonente,
                          iExp,
                          nombre,
                          idPais,
                        )
                      }
                      paises={paises || []}
                      disabled={crearEmpresa.isPending}
                    />
                  </div>
                </div>
              )
            })}
          </section>

          <Separator />

          {/* Grados académicos */}
          <section className="space-y-3">
            <div className="flex items-center justify-between gap-2">
              <h4 className="text-sm font-semibold">
                Grados académicos
              </h4>
              <Button
                type="button"
                size="sm"
                variant="outline"
                onClick={() => addGrado(iPonente)}
              >
                Agregar grado
              </Button>
            </div>

            {p.grados.length === 0 && (
              <p className="text-[11px] text-slate-500">
                No hay grados agregados.
              </p>
            )}

            {p.grados.map((g, iGrado) => (
              <div
                key={iGrado}
                className="rounded-md border border-slate-200 p-3 space-y-3"
              >
                <div className="flex justify-between items-center">
                  <span className="text-xs font-medium">
                    Grado #{iGrado + 1}
                  </span>
                  <Button
                    type="button"
                    size="icon"
                    variant="ghost"
                    onClick={() =>
                      removeGrado(iPonente, iGrado)
                    }
                  >
                    ✕
                  </Button>
                </div>

                <div className="grid md:grid-cols-3 gap-3">
                  <div>
                    <label className="block text-xs font-medium">
                      Título del grado
                    </label>
                    <Input
                      value={g.titulo}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          titulo: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="block text-xs font-medium">
                      Nivel
                    </label>
                    <select
                      className="border rounded-md px-2 py-2 w-full text-sm"
                      value={g.idNivel ?? ''}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          idNivel: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">
                        Selecciona un nivel
                      </option>
                      {(niveles || []).map((n) => (
                        <option
                          key={n.id}
                          value={n.id}
                        >
                          {n.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="block text-xs font-medium">
                      País del grado
                    </label>
                    <select
                      className="border rounded-md px-2 py-2 w-full text-sm"
                      value={g.idPais ?? ''}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          idPais: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">
                        Selecciona un país
                      </option>
                      {(paises || []).map((pais) => (
                        <option
                          key={pais.id}
                          value={pais.id}
                        >
                          {pais.nombre}
                        </option>
                      ))}
                    </select>
                  </div>
                </div>

                <div className="grid md:grid-cols-[2fr_1fr] gap-3 items-end">
                  <div>
                    <label className="block text-xs font-medium">
                      Institución
                    </label>
                    <select
                      className="border rounded-md px-2 py-2 w-full text-sm"
                      value={g.idInstitucion ?? ''}
                      onChange={(e) =>
                        updateGrado(iPonente, iGrado, {
                          idInstitucion: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                    >
                      <option value="">
                        Selecciona una institución
                      </option>
                      {(instituciones || []).map((inst) => (
                        <option
                          key={inst.id}
                          value={inst.id}
                        >
                          {inst.nombre}
                        </option>
                      ))}
                    </select>
                  </div>

                  {/* Form rápido nueva institución */}
                  <NuevaInstitucionInline
                    onCrear={(nombre, siglas) =>
                      handleCrearInstitucion(
                        iPonente,
                        iGrado,
                        nombre,
                        siglas,
                      )
                    }
                    disabled={crearInstitucion.isPending}
                  />
                </div>
              </div>
            ))}
          </section>
        </div>
      ))}
    </div>
  )
}

// --- Componentes inline auxiliares ---

type NuevaEmpresaInlineProps = {
  paises: Option[]
  disabled?: boolean
  onCrear: (nombre: string, idPais: number | null) => void
}

function NuevaEmpresaInline({
  paises,
  disabled,
  onCrear,
}: NuevaEmpresaInlineProps) {
  const [nombre, setNombre] = useState('')
  const [idPais, setIdPais] = useState<number | null>(null)

  return (
    <div className="space-y-1">
      <label className="block text-xs font-medium">
        Nueva empresa (opcional)
      </label>
      <div className="grid grid-cols-1 gap-2">
        <Input
          placeholder="Nombre de la empresa"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
        />
        <select
          className="border rounded-md px-2 py-2 w-full text-sm"
          value={idPais ?? ''}
          onChange={(e) =>
            setIdPais(
              e.target.value ? Number(e.target.value) : null,
            )
          }
        >
          <option value="">País de la empresa</option>
          {paises.map((p) => (
            <option key={p.id} value={p.id}>
              {p.nombre}
            </option>
          ))}
        </select>
        <Button
          type="button"
          size="sm"
          variant="outline"
          disabled={disabled}
          onClick={() => {
            onCrear(nombre, idPais)
            setNombre('')
            setIdPais(null)
          }}
        >
          Guardar empresa
        </Button>
      </div>
    </div>
  )
}

type NuevaInstitucionInlineProps = {
  disabled?: boolean
  onCrear: (nombre: string, siglas: string) => void
}

function NuevaInstitucionInline({
  disabled,
  onCrear,
}: NuevaInstitucionInlineProps) {
  const [nombre, setNombre] = useState('')
  const [siglas, setSiglas] = useState('')

  return (
    <div className="space-y-1">
      <label className="block text-xs font-medium">
        Nueva institución (opcional)
      </label>
      <div className="grid grid-cols-1 gap-2">
        <Input
          placeholder="Nombre de la institución"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
        />
        <Input
          placeholder="Siglas"
          value={siglas}
          onChange={(e) => setSiglas(e.target.value)}
        />
        <Button
          type="button"
          size="sm"
          variant="outline"
          disabled={disabled}
          onClick={() => {
            onCrear(nombre, siglas)
            setNombre('')
            setSiglas('')
          }}
        >
          Guardar institución
        </Button>
      </div>
    </div>
  )
}
