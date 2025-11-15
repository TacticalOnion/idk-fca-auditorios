import { useMemo, useState } from 'react'
import { useMutation, useQueryClient } from '@tanstack/react-query'
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
import { toast } from 'sonner'
import { api } from '@/lib/api'
import EventDetailSheet from '@/pages/eventos/EventDetailSheet'
import { CancelEventPopover } from '../eventos/CancelEventPopover'

type MisKanbanViewProps = {
  data: Evento[]
  onEdit: (evento: Evento) => void
}

type CancelarPayload = {
  id: number
  motivo: string
}

export default function MisKanbanView({ data, onEdit }: MisKanbanViewProps) {
  const [openDetail, setOpenDetail] = useState(false)
  const [selId, setSelId] = useState<number | null>(null)

  const queryClient = useQueryClient()

  function openDetailSheet(ev: Evento) {
    setSelId(ev.id)
    setOpenDetail(true)
  }

  const columns = useMemo(
    () => ({
      pendiente: data.filter((e) => e.estatus === 'pendiente'),
      autorizado: data.filter((e) => e.estatus === 'autorizado'),
      cancelado: data.filter((e) => e.estatus === 'cancelado'),
    }),
    [data],
  )

  const formatDate = (value?: string | null) => {
    if (!value) return '—'
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

  // --- Mutations ---

  // Cancelar con motivo (igual idea que en KanbanView)
  const cancelar = useMutation({
    mutationFn: async ({ id, motivo }: CancelarPayload) => {
      await api.post(`/api/eventos/${id}/cancelar`, null, {
        params: { motivo },
      })
    },
    onSuccess: () => {
      toast.success('Evento cancelado correctamente')
      queryClient.invalidateQueries({ queryKey: ['mis-eventos'] })
      queryClient.invalidateQueries({ queryKey: ['eventos'] })
    },
    onError: (error: unknown) => {
      const message =
        (error as { response?: { data?: { message?: string } } })?.response
          ?.data?.message ?? 'No se pudo cancelar el evento'
      toast.error('Error al cancelar el evento', { description: message })
    },
  })

  // Deshacer: regresa a pendiente y pone motivo = NULL (backend se encarga)
  const deshacer = useMutation({
    mutationFn: async (idEvento: number) => {
      await api.post(`/api/eventos/${idEvento}/deshacer`)
    },
    onSuccess: () => {
      toast.success('Cambios revertidos. El evento regresó a pendiente.')
      queryClient.invalidateQueries({ queryKey: ['mis-eventos'] })
      queryClient.invalidateQueries({ queryKey: ['eventos'] })
    },
    onError: (error: unknown) => {
      const message =
        (error as { response?: { data?: { message?: string } } })?.response
          ?.data?.message ?? 'No se pudo deshacer el cambio'
      toast.error('Error al deshacer el cambio', { description: message })
    },
  })

  const handleDeshacerClick = (evento: Evento) => {
    if (evento.estatus !== 'cancelado' && evento.estatus !== 'autorizado') {
      return
    }
    deshacer.mutate(evento.id)
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
                    {/* Detalles */}
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => openDetailSheet(evento)}
                    >
                      Detalles
                    </Button>

                    {/* Editar */}
                    <Button
                      size="sm"
                      variant="ghost"
                      onClick={() => onEdit(evento)}
                    >
                      Editar
                    </Button>

                    {/* Cancelar / Deshacer según estatus */}
                    {evento.estatus === 'pendiente' && (
                      <CancelEventPopover
                        disabled={cancelar.isPending}
                        onConfirm={(motivo) => cancelar.mutate({ id: evento.id, motivo })}
                      >
                        <Button size="sm" variant="destructive">
                          Cancelar
                        </Button>
                      </CancelEventPopover>
                    )}

                    {evento.estatus === 'cancelado' && (
                      <Button
                        size="sm"
                        variant="outline"
                        disabled={deshacer.isPending}
                        onClick={() => handleDeshacerClick(evento)}
                      >
                        Deshacer
                      </Button>
                    )}
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

      {/* Sheet de detalle compartido con admin */}
      {selId !== null && (
        <EventDetailSheet
          id={selId}
          open={openDetail}
          onOpenChange={(isOpen) => {
            setOpenDetail(isOpen)
            if (!isOpen) {
              setSelId(null)
            }
          }}
          basePath="/api/mis-eventos"
        />
      )}
    </div>
  )
}
