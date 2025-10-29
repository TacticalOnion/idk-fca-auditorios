import { useMemo, useState } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { KanbanBoard } from '@/components/kanban/KanbanBoard'
import { EventsTableView } from '@/components/table/EventsTableView'
import { EventsCalendar } from '@/components/calendar/EventsCalendar'
import { useEvents } from '@/hooks/useEvents'
import { EventSheet } from '@/components/events/EventSheet'
import type { EventItem, Status } from '@/types/event'

export default function App() {
  const { events, setEvents } = useEvents()
  const [active, setActive] = useState<'kanban' | 'tabla' | 'calendario'>('kanban')
  const [selected, setSelected] = useState<EventItem | null>(null)

  const byStatus = useMemo(() => ({
    pendiente: events.filter((e: EventItem) => e.status === 'Pendiente'),
    autorizado: events.filter((e: EventItem) => e.status === 'Autorizado'),
    cancelado: events.filter((e: EventItem) => e.status === 'Cancelado'),
  }), [events])

  return (
    <div className="min-h-screen p-4 md:p-6">
      <header className="mb-4 flex items-center justify-between">
        <h1 className="text-2xl md:text-3xl font-semibold">Dashboard de Eventos</h1>
      </header>

      <Tabs value={active} onValueChange={(value: string) => setActive(value as 'kanban' | 'tabla' | 'calendario')}>
        <TabsList className="grid grid-cols-3 w-full sm:w-auto">
          <TabsTrigger value="kanban">Kanban</TabsTrigger>
          <TabsTrigger value="tabla">Registros</TabsTrigger>
          <TabsTrigger value="calendario">Calendario</TabsTrigger>
        </TabsList>

        <TabsContent value="kanban" className="mt-4">
          <KanbanBoard
            data={byStatus}
            onOpen={setSelected}
            onStatusChange={(id: string, status: Status) => {
              setEvents((prev: EventItem[]) =>
                prev.map((e: EventItem) => (e.id === id ? { ...e, status } : e))
              )
            }}
          />
        </TabsContent>

        <TabsContent value="tabla" className="mt-4">
          <EventsTableView
            events={events}
            onOpen={setSelected}
            onBulkStatus={(ids: string[], status: Status) => {
              setEvents((prev: EventItem[]) =>
                prev.map((e: EventItem) => (ids.includes(e.id) ? { ...e, status } : e))
              )
            }}
          />
        </TabsContent>

        <TabsContent value="calendario" className="mt-4">
          <EventsCalendar events={events} onOpen={setSelected} />
        </TabsContent>
      </Tabs>

      <EventSheet
        event={selected}
        onClose={() => setSelected(null)}
        onStatusChange={(status: Status) => {
          if (!selected) return
          setEvents((prev: EventItem[]) =>
            prev.map((e: EventItem) => (e.id === selected.id ? { ...e, status } : e))
          )
        }}
      />
    </div>
  )
}
