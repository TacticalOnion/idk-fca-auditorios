import type { Evento } from '@/types'
import CalendarView from '@/pages/eventos/CalendarView'

export default function MisCalendarView({ data }: { data: Evento[] }) {
  return (
    <CalendarView
      data={data}
      basePath="/api/mis-eventos"
    />
  )
}
