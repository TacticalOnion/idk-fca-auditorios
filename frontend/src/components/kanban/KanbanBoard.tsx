import { Card } from '@/components/ui/card'
import type { EventItem, Status } from '@/types/event'
import { EventBadges } from '@/components/events/EventBadges'
import { fmtDate, fmtTime } from '@/utils/date'

export function KanbanBoard({
  data, onOpen, onStatusChange
}:{
  data: {pendiente:EventItem[]; autorizado:EventItem[]; cancelado:EventItem[]}
  onOpen: (e:EventItem)=>void
  onStatusChange: (id:string, status: Status)=>void
}){
  const columns: {key: keyof typeof data; title:string}[] = [
    {key:'pendiente', title:'Pendiente'},
    {key:'autorizado', title:'Autorizado'},
    {key:'cancelado', title:'Cancelado'},
  ]
  const color = (k:keyof typeof data)=> k==='pendiente'? 'border-yellow-300' : k==='autorizado'? 'border-green-300' : 'border-red-300'

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
      {columns.map(col=> (
        <div key={col.key} className={`rounded-2xl border ${color(col.key)} p-2 bg-neutral-50 dark:bg-neutral-950`}>
          <h3 className="px-2 py-2 font-semibold">{col.title}</h3>
          <div className="space-y-2">
            {data[col.key].map(e=> (
              <Card key={e.id} className="cursor-pointer" onClick={()=> onOpen(e)}>
                <div className="space-y-1">
                  <div className="font-medium">{e.name}</div>
                  <EventBadges e={e} />
                  <div className="text-xs text-neutral-500">
                    {fmtDate(e.startDate)} - {fmtDate(e.endDate)} · {fmtTime(e.startTime)} - {fmtTime(e.endTime)}
                  </div>
                  <div className="flex gap-2 pt-1">
                    <button
                      onClick={(ev)=> {ev.stopPropagation(); onStatusChange(e.id, nextStatus(e.status))}}
                      className="text-xs underline"
                    >
                      Mover a {nextStatus(e.status)}
                    </button>
                  </div>
                </div>
              </Card>
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}

function nextStatus(s:Status): Status {
  return s==='Pendiente'? 'Autorizado' : s==='Autorizado'? 'Cancelado' : 'Pendiente'
}
