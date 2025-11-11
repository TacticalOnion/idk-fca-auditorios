import { startOfMonth, endOfMonth, eachDayOfInterval, format, parseISO } from 'date-fns'
import { es } from 'date-fns/locale'
import type { Evento } from '../../types'

export default function CalendarView({ data }: { data: Evento[] }) {
  const today = new Date()
  const start = startOfMonth(today)
  const end = endOfMonth(today)
  const days = eachDayOfInterval({ start, end })

  function eventsOn(day: Date){
    return (data||[]).filter(e=>{
      const fi = e.fechaInicio ? parseISO(e.fechaInicio) : null
      const ff = e.fechaFin ? parseISO(e.fechaFin) : fi
      if (!fi) return false
      return (fi <= day && day <= (ff||fi))
    })
  }

  return (
    <div className="grid grid-cols-7 gap-2">
      {['Lun','Mar','Mié','Jue','Vie','Sáb','Dom'].map(h=><div key={h} className="text-xs font-semibold text-gray-600">{h}</div>)}
      {days.map(d=>(
        <div key={d.toISOString()} className="min-h-24 border rounded-md p-2 bg-white">
          <div className="text-xs text-gray-600">{format(d,'d MMM', { locale: es })}</div>
          <div className="space-y-1 mt-1">
            {eventsOn(d).slice(0,3).map((e)=>(
              <div key={e.id} className="text-[11px] px-2 py-1 rounded bg-primary/10">{e.nombre}</div>
            ))}
            {eventsOn(d).length>3 && <div className="text-[11px] text-gray-500">+{eventsOn(d).length-3} más</div>}
          </div>
        </div>
      ))}
    </div>
  )
}
