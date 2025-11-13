import { useMemo } from 'react'
import { useMutation, useQueryClient } from '@tanstack/react-query'
import { toast } from 'sonner'

import { api } from '@/lib/api'
import type { Evento } from '@/types'
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  CardFooter,
  Button,
  Badge,
} from '@ui/index'
import axios from 'axios'
import { ClipboardCheck } from 'lucide-react'

type KanbanViewProps = {
  data: Evento[]
}

type CancelarPayload = {
  id: number
  motivo: string
}

export default function KanbanView({ data }: KanbanViewProps) {
  const queryClient = useQueryClient()

  const verificar = useMutation({
    mutationFn: async (id: number) =>
      (
        await api.get<
          Array<{ faltante: number; nombre_equipamiento: string }>
        >(`/api/eventos/${id}/verificar-equipamiento`)
      ).data,
    onSuccess: (rows) => {
      if (!rows?.length) {
        toast.success('Sin requerimientos registrados')
        return
      }
      const faltantes = rows.filter((r) => Number(r.faltante) > 0)
      if (faltantes.length === 0) toast.success('Equipamiento suficiente')
      else
        toast.warning(
          'Equipamiento insuficiente: ' +
            faltantes.map((x) => x.nombre_equipamiento).join(', '),
        )
    },
    onError: (err: unknown) =>
      toast.error(
        axios.isAxiosError(err)
          ? (err.response?.data as { message?: string })?.message ??
              'Error al verificar'
          : 'Error al verificar',
      ),
  })

  // --- Mutations ---
  
  const autorizar = useMutation({
    mutationFn: async (id: number) => {
      const { data } = await api.post<Evento>(`/api/eventos/${id}/autorizar`)
      return data
    },
    onSuccess: () => {
      // Mensaje según reglas del sistema
      toast.success('Evento autorizado', {
        description:
          'Se notificó a los responsables para que preparen el equipamiento.',
      })
      queryClient.invalidateQueries({ queryKey: ['eventos'] })
    },
    onError: (error: unknown) => {
      const message =
        (error as { response?: { data?: { message?: string } } })?.response
          ?.data?.message ?? 'No se pudo autorizar el evento.'
      toast.error('Error al autorizar el evento', { description: message })
    },
  })

  const cancelar = useMutation({
    mutationFn: async ({ id, motivo }: CancelarPayload) => {
      const { data } = await api.post<Evento>(
        `/api/eventos/${id}/cancelar`,
        null,
        {
          params: { motivo },
        },
      )
      return data
    },
    onSuccess: () => {
      toast.success('Evento cancelado', {
        description:
          'Se notificó a los responsables para que preparen el equipamiento.',
      })
      queryClient.invalidateQueries({ queryKey: ['eventos'] })
    },
    onError: (error: unknown) => {
      const message =
        (error as { response?: { data?: { message?: string } } })?.response
          ?.data?.message ?? 'No se pudo cancelar el evento.'
      toast.error('Error al cancelar el evento', { description: message })
    },
  })

  const deshacer = useMutation({
    mutationFn: async (id: number) => {
      const { data } = await api.post<Evento>(`/api/eventos/${id}/deshacer`)
      return data
    },
    onSuccess: () => {
      toast.success('Cambios revertidos', {
        description: 'El evento regresó al estado pendiente.',
      })
      queryClient.invalidateQueries({ queryKey: ['eventos'] })
    },
    onError: (error: unknown) => {
      const message =
        (error as { response?: { data?: { message?: string } } })?.response
          ?.data?.message ?? 'No se pudo deshacer el cambio.'
      toast.error('Error al deshacer cambio', { description: message })
    },
  })

  // --- Columns by status ---

  const columns = useMemo(
    () => ({
      pendiente: data.filter((e) => e.estatus === 'pendiente'),
      autorizado: data.filter((e) => e.estatus === 'autorizado'),
      cancelado: data.filter((e) => e.estatus === 'cancelado'),
    }),
    [data],
  )

  const handleAutorizar = (id: number) => {
    autorizar.mutate(id)
  }

  const handleCancelar = (id: number) => {
    const motivo = window.prompt('Indica el motivo de cancelación')

    if (!motivo || !motivo.trim()) {
      toast.error('Debes indicar un motivo para cancelar el evento.')
      return
    }

    cancelar.mutate({ id, motivo: motivo.trim() })
  }

  const handleDeshacer = (id: number) => {
    deshacer.mutate(id)
  }

  const renderCardActions = (evento: Evento) => {
    if (evento.estatus === 'pendiente') {
      return (
        <>
          <Button
            variant="ghost"
            size="icon"
            onClick={() => verificar.mutate(evento.id)}
            title="Verificar equipamiento"
          >
            <ClipboardCheck size={18} />
          </Button>
          <Button
            size="sm"
            variant="outline"
            onClick={() => handleAutorizar(evento.id)}
            disabled={autorizar.isPending}
          >
            Autorizar
          </Button>
          <Button
            size="sm"
            variant="destructive"
            onClick={() => handleCancelar(evento.id)}
            disabled={cancelar.isPending}
          >
            Cancelar
          </Button>
        </>
      )
    }

    if (evento.estatus === 'autorizado' || evento.estatus === 'cancelado') {
      return (
        <Button
          size="sm"
          variant="outline"
          onClick={() => handleDeshacer(evento.id)}
          disabled={deshacer.isPending}
        >
          Deshacer
        </Button>
      )
    }

    return null
  }

  const formatDate = (value?: string | null) => {
    if (!value) return '—'
    // El backend trae 'YYYY-MM-DD', esto lo convierte a fecha legible local
    const date = new Date(value)
    if (Number.isNaN(date.getTime())) return value
    return date.toLocaleDateString('es-MX', {
      year: 'numeric',
      month: 'short',
      day: '2-digit',
    })
  }

  const formatTime = (value?: string | null) => {
    if (!value) return '—'
    // value viene como 'HH:mm:ss'
    const [hours, minutes] = value.split(':')
    if (!hours || !minutes) return value
    const date = new Date()
    date.setHours(Number(hours), Number(minutes), 0, 0)
    return date.toLocaleTimeString('es-MX', {
      hour: '2-digit',
      minute: '2-digit',
    })
  }

  const getColumnTitle = (key: keyof typeof columns) => {
    switch (key) {
      case 'pendiente':
        return 'Pendientes'
      case 'autorizado':
        return 'Autorizados'
      case 'cancelado':
        return 'Cancelados'
      default:
        return key
    }
  }

  return (
    <div className="grid gap-4 md:grid-cols-3">
      {(Object.keys(columns) as Array<keyof typeof columns>).map((key) => {
        const eventos = columns[key]
        const title = getColumnTitle(key)

        return (
          <div key={key} className="flex flex-col gap-2">
            <div className="flex items-center justify-between">
              <h2 className="font-semibold">{title}</h2>
              <Badge variant="outline">{eventos.length}</Badge>
            </div>

            <div className="flex flex-col gap-2">
              {eventos.map((evento) => (
                <Card key={evento.id} className="border border-slate-200">
                  <CardHeader className="space-y-1 pb-2">
                    <CardTitle className="flex flex-wrap gap-1 text-sm font-semibold">
                      {evento.id}. {evento.nombre} 
                      {evento.categoria && (
                        <Badge variant="outline">{evento.categoria}</Badge>
                      )}
                    </CardTitle>
                    <div className="flex flex-wrap gap-1 text-xs text-slate-500">
                      
                      {evento.isMegaEvento && (
                        <Badge variant="outline">Mega evento</Badge>
                      )}
                      {evento.recinto && (
                        <span className="truncate">{evento.recinto}</span>
                      )}
                    </div>
                  </CardHeader>

                  <CardContent className="space-y-1 pb-2 text-xs text-slate-600">
                    <div>
                      <span className="font-medium">Fecha:&nbsp;</span>
                      {formatDate(evento.fechaInicio)}{' '}
                      {evento.fechaFin &&
                        evento.fechaFin !== evento.fechaInicio &&
                        `– ${formatDate(evento.fechaFin)}`}
                    </div>
                    <div>
                      <span className="font-medium">Horario:&nbsp;</span>
                      {formatTime(evento.horarioInicio)} –{' '}
                      {formatTime(evento.horarioFin)}
                    </div>
                  </CardContent>

                  <CardFooter className="flex gap-2 pt-2">
                    {renderCardActions(evento)}
                  </CardFooter>
                </Card>
              ))}

              {eventos.length === 0 && (
                <div className="rounded-md border border-dashed border-slate-200 p-3 text-center text-xs text-slate-400">
                  No hay eventos en esta columna
                </div>
              )}
            </div>
          </div>
        )
      })}
    </div>
  )
}
