import { useState } from 'react'
import {
  startOfMonth,
  endOfMonth,
  eachDayOfInterval,
  format,
  parseISO,
  addMonths,
  setMonth,
  setYear,
  getMonth,
  getYear,
} from 'date-fns'
import { es } from 'date-fns/locale'
import type { Evento } from '../../types'
import { ChevronLeft, ChevronRight } from 'lucide-react'

export default function CalendarView({ data }: { data: Evento[] }) {
  // Estado para el mes que se está viendo, por defecto el mes actual
  const [currentMonth, setCurrentMonth] = useState<Date>(startOfMonth(new Date()))

  const start = startOfMonth(currentMonth)
  const end = endOfMonth(currentMonth)
  const days = eachDayOfInterval({ start, end })

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

  function eventsOn(day: Date) {
    return (data || []).filter((e) => {
      const fi = e.fechaInicio ? parseISO(e.fechaInicio) : null
      const ff = e.fechaFin ? parseISO(e.fechaFin) : fi
      if (!fi) return false
      return fi <= day && day <= (ff || fi)
    })
  }

  function handlePrevMonth() {
    setCurrentMonth((prev) => addMonths(prev, -1))
  }

  function handleNextMonth() {
    setCurrentMonth((prev) => addMonths(prev, 1))
  }

  function handleMonthChange(e: React.ChangeEvent<HTMLSelectElement>) {
    const monthIndex = Number(e.target.value) // 0-11
    setCurrentMonth((prev) => setMonth(prev, monthIndex))
  }

  function handleYearChange(e: React.ChangeEvent<HTMLSelectElement>) {
    const year = Number(e.target.value)
    setCurrentMonth((prev) => setYear(prev, year))
  }

  const currentMonthIndex = getMonth(currentMonth)
  const currentYear = getYear(currentMonth)

  // Rango de años navegables (ajústalo a lo que te haga sentido)
  const yearOptions = []
  const baseYear = getYear(new Date())
  for (let y = baseYear - 5; y <= baseYear + 5; y++) {
    yearOptions.push(y)
  }

  const monthLabels = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ]

  return (
    <div className="space-y-4">
      {/* Toolbar de navegación del calendario */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={handlePrevMonth}
            className="p-1 rounded hover:bg-gray-100"
          >
            <ChevronLeft size={20} strokeWidth={2} color="rgb(0, 93, 111)" />
          </button>

          <div className="font-semibold">
            {format(currentMonth, 'MMMM yyyy', { locale: es })}
          </div>

          <button
            type="button"
            onClick={handleNextMonth}
            className="p-1 rounded hover:bg-gray-100"
          >
            <ChevronRight size={20} strokeWidth={2} color="rgb(0, 93, 111)" />
          </button>
        </div>


        <div className="flex items-center gap-2">
          <select
            value={currentMonthIndex}
            onChange={handleMonthChange}
            className="border rounded px-2 py-1 text-sm"
          >
            {monthLabels.map((m, idx) => (
              <option key={m} value={idx}>
                {m}
              </option>
            ))}
          </select>

          <select
            value={currentYear}
            onChange={handleYearChange}
            className="border rounded px-2 py-1 text-sm"
          >
            {yearOptions.map((y) => (
              <option key={y} value={y}>
                {y}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Calendario */}
      <div className="grid grid-cols-7 gap-2">
        {['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'].map((h) => (
          <div key={h} className="text-xs font-semibold text-gray-600">
            {h}
          </div>
        ))}
        {days.map((d) => (
          <div
            key={d.toISOString()}
            className="min-h-24 border rounded-md p-2 bg-white"
          >
            <div className="text-xs text-gray-600">
              {format(d, 'd MMM', { locale: es })}
            </div>
            <div className="space-y-1 mt-1">
              {eventsOn(d)
                .slice(0, 3)
                .map((e) => (
                  <div
                    key={e.id}
                    className="px-2 py-1 rounded bg-primary/10"
                  >
                    <div className="text-[11px] font-medium">
                      {e.nombre}
                    </div>
                    <div className="text-[11px]">
                      {formatTime(e.horarioInicio)} - {formatTime(e.horarioFin)}
                    </div>
                  </div>
                  
                ))}
              {eventsOn(d).length > 3 && (
                <div className="text-[11px] text-gray-500">
                  +{eventsOn(d).length - 3} más
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
