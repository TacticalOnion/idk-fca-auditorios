// src/pages/mis-eventos/EventoFormSheet.tsx
import { useEffect, useMemo } from 'react'
import { useForm } from 'react-hook-form'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetDescription,
  Button,
  Input,
  Textarea,
  Separator,
  Badge,
} from '@ui/index'
import { toast } from 'sonner'
import { api } from '@/lib/api'
import type {
  DetalleEvento,
  Evento,
  OrganizadorEvento,
  EquipamientoEvento,
  EventoConRelaciones,
  PonenteEvento
} from '@/types'
import PonentesForm, {
  type PonenteFormValue,
} from '@/pages/mis-eventos/PonentesForm'

type EventoFormSheetProps = {
  open: boolean
  onOpenChange: (open: boolean) => void
  mode: 'create' | 'edit'
  eventoId?: number
}

/**
 * Estructura simplificada de los valores del formulario.
 * Aquí podrías agregar toda la parte de ponentes (semblanza, reconocimientos, experiencia, grados)
 * siguiendo el JSON que definiste.
 */
type FormValues = {
  nombre: string
  idCategoria: number | null
  idMegaEvento: number | null
  isMegaEvento: boolean
  idRecinto: number | null
  fechaInicio: string
  fechaFin: string
  horarioInicio: string
  horarioFin: string
  presencial: boolean
  online: boolean
  estatus: string
  descripcion: string
  // Simplificado: estos arrays se mandan tal cual al backend
  organizadores: { idUsuario: number }[]
  equipamiento: { idEquipamiento: number; cantidad: number }[]
  ponentes: PonenteFormValue[]
}

// Opciones genéricas de catálogos
type Option = {
  id: number
  nombre: string
}

// Mapper de PonenteEvento (backend) -> PonenteFormValue (formulario)
function mapPonenteEventoToFormValue(
  ponente: PonenteEvento,
): PonenteFormValue {
  const fullName = (ponente.nombreCompleto ?? '').trim()

  // Partimos el nombre completo en partes:
  // [nombre, apellidoPaterno, ...resto (apellidoMaterno)]
  const parts = fullName.split(/\s+/)
  const nombre = parts[0] ?? ''
  const apellidoPaterno = parts[1] ?? ''
  const apellidoMaterno = parts.slice(2).join(' ')

  // Si el backend trae un texto de reconocimiento simple,
  // lo tomamos como un reconocimiento inicial en el formulario.
  const reconocimientos: PonenteFormValue['reconocimientos'] =
    ponente.reconocimiento
      ? [
          {
            idSemblanza: null,
            idReconocimiento: undefined,
            titulo: ponente.reconocimiento,
            organizacion: '',
            anio: '',
            descripcion: '',
          },
        ]
      : []

  return {
    id: ponente.id,
    nombre,
    apellidoPaterno,
    apellidoMaterno,
    idPais: null,
    semblanza: ponente.semblanza ?? '',
    reconocimientos,
    experiencia: [],
    grados: [],
  }
}

export default function EventoFormSheet({
  open,
  onOpenChange,
  mode,
  eventoId,
}: EventoFormSheetProps) {
  const queryClient = useQueryClient()

  // En edición, cargamos el detalle del evento
  const { data: detalle, isLoading: loadingDetalle } = useQuery({
      enabled: mode === 'edit' && !!eventoId,
      queryKey: ['evento-detalle', eventoId],
      queryFn: async () =>
          (await api.get<DetalleEvento>(`/api/eventos/${eventoId}/detalle`)).data,
  })

  // Catálogos: categorías, mega-eventos, recintos, organizadores, equipamiento, etc.
  const { data: categorias } = useQuery({
      queryKey: ['catalogo-categorias'],
      queryFn: async () =>
          (await api.get<Option[]>('/api/catalogos/categorias')).data,
  })

  const { data: megaEventos } = useQuery({
      queryKey: ['catalogo-megaeventos'],
      queryFn: async () =>
          (await api.get<Option[]>('/api/catalogos/mega-eventos')).data,
  })

  const { data: recintos } = useQuery({
      queryKey: ['catalogo-recintos'],
      queryFn: async () =>
          (await api.get<Option[]>('/api/recintos')).data,
  })

  const { data: usuariosFuncionario } = useQuery({
      queryKey: ['catalogo-funcionarios'],
      queryFn: async () =>
          (
          await api.get<Option[]>(
              '/api/usuarios?rol=FUNCIONARIO',
          )
          ).data,
  })

  const { data: equipamientosDisponibles } = useQuery({
      queryKey: ['catalogo-equipamiento'],
      queryFn: async () =>
          (await api.get<Option[]>('/api/equipamiento?disponible=true')).data,
  })

  const defaultValues: FormValues = useMemo(() => {
      if (mode === 'edit' && detalle?.evento) {
      const ev = detalle.evento as Evento

  const organizadores: { idUsuario: number }[] =
  (detalle.organizadores as OrganizadorEvento[])?.map((o) => ({
      idUsuario: o.idUsuario ?? 0,
  }))

  const equipamiento: { idEquipamiento: number; cantidad: number }[] =
  (detalle.equipamiento as EquipamientoEvento[])?.map((eq) => ({
      idEquipamiento: eq.idEquipamiento ?? 0,
      cantidad: Number(eq.cantidad ?? 1),
  }))
    
  const evr = detalle.evento as EventoConRelaciones

  // Mapear ponentes del backend a lo que espera el formulario
  const ponentesForm: PonenteFormValue[] =
    (detalle.ponentes as PonenteEvento[] | undefined)?.map(
      (p) => mapPonenteEventoToFormValue(p),
    ) ?? []

  return {
    nombre: ev.nombre ?? '',
    idCategoria: evr.idCategoria ?? null,
    idMegaEvento: evr.idMegaEvento ?? null,
    isMegaEvento: Boolean(ev.isMegaEvento),
    idRecinto: evr.idRecinto ?? null,
    fechaInicio: ev.fechaInicio ?? '',
    fechaFin: ev.fechaFin ?? '',
    horarioInicio: ev.horarioInicio ?? '',
    horarioFin: ev.horarioFin ?? '',
    presencial: Boolean(ev.presencial),
    online: Boolean(ev.online),
    estatus: ev.estatus ?? 'pendiente',
    descripcion: ev.descripcion ?? '',
    organizadores,
    equipamiento,
    ponentes: ponentesForm,
  }
}

// Valores por defecto al crear
return {
    nombre: '',
    idCategoria: null,
    idMegaEvento: null,
    isMegaEvento: false,
    idRecinto: null,
    fechaInicio: '',
    fechaFin: '',
    horarioInicio: '',
    horarioFin: '',
    presencial: true,
    online: false,
    estatus: 'pendiente',
    descripcion: '',
    organizadores: [],
    equipamiento: [],
    ponentes: [],
}
  }, [mode, detalle])

  const {
    register,
    handleSubmit,
    reset,
    watch,
    setValue,
    formState: { isSubmitting },
  } = useForm<FormValues>({
    defaultValues,
  })

  // Cuando cambie el detalle (modo edición), actualizamos el formulario
  useEffect(() => {
    if (mode === 'edit' && detalle) {
      reset(defaultValues)
    }
  }, [mode, detalle, reset, defaultValues])

  // Mutación para crear/actualizar
  const mutation = useMutation({
    mutationFn: async (values: FormValues) => {
      // payload tal cual; el backend asignará IDs de ponentes/semblanza/etc.
      if (mode === 'create') {
        return (await api.post<Evento>('/api/eventos', values)).data
      }
      if (!eventoId) throw new Error('Falta id de evento para edición')
      return (await api.put<Evento>(`/api/eventos/${eventoId}`, values)).data
    },
    onSuccess: () => {
      toast.success(
        mode === 'create'
          ? 'Evento creado correctamente'
          : 'Evento actualizado correctamente',
      )
      queryClient.invalidateQueries({ queryKey: ['mis-eventos'] })
      queryClient.invalidateQueries({ queryKey: ['eventos'] })
      onOpenChange(false)
    },
    onError: (error: unknown) => {
      const message =
        (error as { response?: { data?: { message?: string } } })?.response
          ?.data?.message ?? 'No se pudo guardar el evento. Revisa que no se traslape el recinto con otro evento pendiente/autorizado.'
      toast.error('Error al autorizar el evento', { description: message })
    },
  })

  const onSubmit = (values: FormValues) => {
    // Reglas adicionales que puedes checar también aquí si quieres:
    // - Solo un puesto con puestoActual = true por ponente (si implementas la parte de experiencia)
    mutation.mutate(values)
  }

  const isMega = watch('isMegaEvento')

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent className="w-full sm:max-w-5xl p-6">
        <SheetHeader>
          <SheetTitle>
            {mode === 'create' ? 'Nuevo evento' : 'Editar evento'}
          </SheetTitle>
          <SheetDescription>
            Completa la información del evento. Los organizadores deben tener rol de funcionario.
          </SheetDescription>
        </SheetHeader>

        <form
          className="mt-4 space-y-6 max-h-[80vh] overflow-y-auto pr-2"
          onSubmit={handleSubmit(onSubmit)}
        >
          {/* Datos básicos */}
          <section className="space-y-3">
            <h3 className="font-semibold">Datos básicos</h3>
            <Separator />

            <div className="space-y-2">
              <label className="block text-sm font-medium">
                Nombre del evento
              </label>
              <Input {...register('nombre', { required: true })} />
            </div>

            <div className="grid md:grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium">Categoría</label>
                <select
                  className="border rounded-md px-2 py-2 w-full text-sm"
                  {...register('idCategoria', { valueAsNumber: true })}
                >
                  <option value="">Selecciona una categoría</option>
                  {(categorias || []).map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.nombre}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium">Mega evento</label>
                <select
                  className="border rounded-md px-2 py-2 w-full text-sm"
                  {...register('idMegaEvento', { valueAsNumber: true })}
                >
                  <option value="">Sin mega evento</option>
                  {(megaEventos || []).map((m) => (
                    <option key={m.id} value={m.id}>
                      {m.nombre}
                    </option>
                  ))}
                </select>
              </div>

              <div className="flex items-center gap-2 mt-5">
                <input
                  type="checkbox"
                  {...register('isMegaEvento')}
                  id="isMegaEvento"
                />
                <label htmlFor="isMegaEvento" className="text-sm">
                  Es mega evento
                </label>
                {isMega && (
                  <Badge variant="secondary" className="ml-2">
                    Mega Evento
                  </Badge>
                )}
              </div>
            </div>

            <div className="grid md:grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium">Recinto</label>
                <select
                  className="border rounded-md px-2 py-2 w-full text-sm"
                  {...register('idRecinto', { valueAsNumber: true })}
                >
                  <option value="">Selecciona un recinto</option>
                  {(recintos || []).map((r) => (
                    <option key={r.id} value={r.id}>
                      {r.nombre}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium">
                  Fecha inicio
                </label>
                <Input type="date" {...register('fechaInicio')} />
              </div>

              <div>
                <label className="block text-sm font-medium">
                  Fecha fin
                </label>
                <Input type="date" {...register('fechaFin')} />
              </div>
            </div>

            <div className="grid md:grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium">
                  Horario inicio
                </label>
                <Input type="time" {...register('horarioInicio')} />
              </div>

              <div>
                <label className="block text-sm font-medium">
                  Horario fin
                </label>
                <Input type="time" {...register('horarioFin')} />
              </div>

              <div className="flex items-center gap-4 mt-6">
                <label className="flex items-center gap-2 text-sm">
                  <input type="checkbox" {...register('presencial')} />
                  Presencial
                </label>
                <label className="flex items-center gap-2 text-sm">
                  <input type="checkbox" {...register('online')} />
                  Online
                </label>
              </div>
            </div>

            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium">Estatus</label>
                <select
                  className="border rounded-md px-2 py-2 w-full text-sm"
                  {...register('estatus')}
                >
                  <option value="pendiente">Pendiente</option>
                  <option value="autorizado">Autorizado</option>
                  <option value="cancelado">Cancelado</option>
                  <option value="realizado">Realizado</option>
                </select>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium">Descripción</label>
              <Textarea
                className="min-h-24"
                {...register('descripcion')}
              />
            </div>
          </section>

          {/* Organizadores (multi-select de funcionarios) */}
          <section className="space-y-3">
            <h3 className="font-semibold">Organizadores</h3>
            <Separator />
            <p className="text-xs text-slate-500 mb-2">
              Puedes seleccionar varios organizadores con rol de funcionario.
            </p>

            <select
              multiple
              className="border rounded-md px-2 py-2 w-full text-sm min-h-32"
              value={(watch('organizadores') || []).map((o) =>
                String(o.idUsuario),
              )}
              onChange={(e) => {
                const selected = Array.from(
                  e.target.selectedOptions,
                ).map((opt) => Number(opt.value))
                const mapped = selected.map((id) => ({ idUsuario: id }))
                setValue('organizadores', mapped)
              }}
            >
              {(usuariosFuncionario || []).map((u) => (
                <option key={u.id} value={u.id}>
                  {u.nombre}
                </option>
              ))}
            </select>
          </section>

          {/* Equipamiento */}
          <section className="space-y-3">
            <h3 className="font-semibold">Equipamiento</h3>
            <Separator />
            <p className="text-xs text-slate-500 mb-2">
              Solo se muestran equipamientos con existencia = TRUE.
            </p>

            {/* Implementación sencilla: un select múltiple + cantidad fija 1.
               Puedes extenderlo a una tabla donde el usuario indique cantidad. */}
            <select
              multiple
              className="border rounded-md px-2 py-2 w-full text-sm min-h-32"
              value={(watch('equipamiento') || []).map((eq) =>
                String(eq.idEquipamiento),
              )}
              onChange={(e) => {
                const selected = Array.from(
                  e.target.selectedOptions,
                ).map((opt) => Number(opt.value))
                const mapped = selected.map((idEquipamiento) => ({
                  idEquipamiento,
                  cantidad: 1,
                }))
                setValue('equipamiento', mapped)
              }}
            >
              {(equipamientosDisponibles || []).map((eq) => (
                <option key={eq.id} value={eq.id}>
                  {eq.nombre}
                </option>
              ))}
            </select>
          </section>

          {/* Ponentes */}
          <section className="space-y-3">
            <h3 className="font-semibold">Ponentes</h3>
            <Separator />
            <p className="text-xs text-slate-500">
              Aquí debes implementar el formulario completo para los ponentes,
              incluyendo:
              <br />
              - Datos básicos del ponente (nombre completo, país) <br />
              - Semblanza (idSemblanza) <br />
              - Reconocimientos (idReconocimiento, título, organización, año,
              descripción) <br />
              - Experiencia (idExperiencia, puesto, puestoActual, fechas,
              empresa, país) <br />
              - Grados (idGrado, título, nivel, institución, país) <br />
              Recuerda que los IDs se generan en backend y que solo debe haber
              un puesto con <code>puestoActual = true</code> por ponente.
            </p>
            <PonentesForm
              value={watch('ponentes') || []}
              onChange={(next) => setValue('ponentes', next)}
            />
          </section>

          {/* Botones */}
          <div className="flex justify-end gap-2 pt-2">
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
            >
              Cancelar
            </Button>
            <Button type="submit" disabled={isSubmitting || loadingDetalle}>
              {mode === 'create' ? 'Crear evento' : 'Guardar cambios'}
            </Button>
          </div>
        </form>
      </SheetContent>
    </Sheet>
  )
}
