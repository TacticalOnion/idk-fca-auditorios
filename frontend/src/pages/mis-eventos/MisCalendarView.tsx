import type { Evento } from '@/types'
import CalendarView from '@/pages/eventos/CalendarView'

export default function MisCalendarView({ data }: { data: Evento[] }) {
  // Simplemente reusa la vista de calendario actual
  return <CalendarView data={data} />
}
