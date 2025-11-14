import { useQuery } from '@tanstack/react-query'
import { useMemo, useState } from 'react'
import { api } from '@/lib/api'
import {
  Button,
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  Input,
  Table,
  TBody,
  TD,
  TH,
  THead,
  TR,
  Tabs,
  TabsList,
  TabsTrigger,
  TabsContent,
} from '@ui/index'
import { toast } from 'sonner'
import type { Evento } from '@/types'
import MisKanbanView from './MisKanbanView'
import MisCalendarView from './MisCalendarView'
import EventDetailSheet from '@/pages/eventos/EventDetailSheet'
import EventoFormSheet from './EventoFormSheet'

export default function MisEventosPage() {
  // Eventos solo del funcionario autenticado (backend filtra por usuario)
  const { data, isLoading, error } = useQuery({
    queryKey: ['mis-eventos'],
    queryFn: async () => (await api.get<Evento[]>('/api/mis-eventos')).data,
  })

  const [q, setQ] = useState('')
  const [estatus, setEstatus] = useState<string>('')
  const [openDetail, setOpenDetail] = useState(false)
  const [selId, setSelId] = useState<number | null>(null)

  // Sheet de creación/edición
  const [openForm, setOpenForm] = useState(false)
  const [editingId, setEditingId] = useState<number | null>(null)

  const filtered = useMemo(
    () =>
      (data || [])
        .filter((e) => e.nombre?.toLowerCase().includes(q.toLowerCase()))
        .filter((e) => !estatus || e.estatus === estatus),
    [data, q, estatus],
  )

  function openDetailSheet(ev: Evento) {
    setSelId(ev.id)
    setOpenDetail(true)
  }

  function handleNew() {
    setEditingId(null)
    setOpenForm(true)
  }

  function handleEdit(id: number) {
    setEditingId(id)
    setOpenForm(true)
  }

  if (error) {
    toast.error('Error al cargar tus eventos')
  }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between gap-4 flex-wrap">
        <CardTitle>Mis eventos</CardTitle>

        <div className="flex gap-2 items-center flex-wrap">
          <Input
            placeholder="Buscar por nombre..."
            value={q}
            onChange={(e) => setQ(e.target.value)}
          />
          <select
            className="border px-2 py-2 rounded-md text-sm"
            value={estatus}
            onChange={(e) => setEstatus(e.target.value)}
          >
            <option value="">Todos</option>
            <option value="pendiente">Pendiente</option>
            <option value="autorizado">Autorizado</option>
            <option value="cancelado">Cancelado</option>
            <option value="realizado">Realizado</option>
          </select>

          {/* Botón NUEVO específico del funcionario */}
          <Button onClick={handleNew}>
            Nuevo
          </Button>
        </div>
      </CardHeader>

      <CardContent className="overflow-auto">
        <Tabs defaultValue="table">
          <TabsList>
            <TabsTrigger value="table">Tabla</TabsTrigger>
            <TabsTrigger value="kanban">Kanban</TabsTrigger>
            <TabsTrigger value="calendar">Calendario</TabsTrigger>
          </TabsList>

          {/* Tabla */}
          <TabsContent value="table">
            {isLoading ? (
              <div className="p-4 text-sm text-slate-500">
                Cargando eventos...
              </div>
            ) : (
              <Table>
                <THead>
                  <TR>
                    <TH>Nombre</TH>
                    <TH>Categoría</TH>
                    <TH>Mega evento</TH>
                    <TH>Recinto</TH>
                    <TH>Fecha inicio</TH>
                    <TH>Fecha fin</TH>
                    <TH>Horario</TH>
                    <TH>Presencial</TH>
                    <TH>Online</TH>
                    <TH>Estatus</TH>
                    <TH className="text-center">Detalles</TH>
                    <TH className="text-center">Editar</TH>
                  </TR>
                </THead>
                <TBody>
                  {filtered.map((e) => (
                    <TR key={e.id} className="align-top">
                      <TD>{e.nombre ?? '-'}</TD>
                      <TD>{e.categoria ?? '-'}</TD>
                      <TD>{e.nombreMegaEvento ?? '-'}</TD>
                      <TD>{e.recinto ?? '-'}</TD>
                      <TD>{e.fechaInicio ?? '-'}</TD>
                      <TD>{e.fechaFin ?? '-'}</TD>
                      <TD>
                        {e.horarioInicio ?? '-'} - {e.horarioFin ?? '-'}
                      </TD>
                      <TD>{e.presencial ? 'Sí' : 'No'}</TD>
                      <TD>{e.online ? 'Sí' : 'No'}</TD>
                      <TD>{e.estatus ?? '-'}</TD>
                      <TD className="text-center">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => openDetailSheet(e)}
                        >
                          Ver
                        </Button>
                      </TD>
                      <TD className="text-center">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleEdit(e.id)}
                        >
                          Editar
                        </Button>
                      </TD>
                    </TR>
                  ))}
                </TBody>
              </Table>
            )}
          </TabsContent>

          {/* Kanban */}
          <TabsContent value="kanban">
            <MisKanbanView
              data={filtered}
              onEdit={(ev) => handleEdit(ev.id)}
            />
          </TabsContent>

          {/* Calendario */}
          <TabsContent value="calendar">
            <MisCalendarView data={filtered} />
          </TabsContent>
        </Tabs>
      </CardContent>

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

      {/* Sheet de creación/edición de evento */}
      <EventoFormSheet
        open={openForm}
        onOpenChange={(isOpen) => {
          setOpenForm(isOpen)
          // Al cerrar, limpiamos el id para que la próxima vez "Nuevo" sea create
          if (!isOpen) {
            setEditingId(null)
          }
        }}
        mode={editingId ? 'edit' : 'create'}
        eventoId={editingId ?? undefined}
      />
    </Card>
  )
}
