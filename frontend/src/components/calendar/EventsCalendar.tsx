import { useMemo, useState } from 'react'
import type { EventItem } from '@/types/event'
import { monthMatrix, nextMonth, prevMonth } from '@/utils/date'
import { Button } from '@/components/ui/button'

export function EventsCalendar({events, onOpen}:{events:EventItem[]; onOpen:(e:EventItem)=>void}){
  const today = new Date()
  const [ym, setYM] = useState<string>(()=> `${today.getFullYear()}-${String(today.getMonth()+1).padStart(2,'0')}`)

  const days = useMemo(()=> monthMatrix(ym), [ym])

  const eventsByDay = useMemo(()=>{
    const map: Record<string, EventItem[]> = {}
    for(const e of events){
      const start = new Date(e.startDate)
      const end = new Date(e.endDate)
      for(let d = new Date(start); d <= end; d.setDate(d.getDate()+1)){
        const key = d.toISOString().slice(0,10)
        map[key] ??= []; map[key].push(e)
      }
    }
    return map
  },[events])

  const year = parseInt(ym.slice(0,4),10)
  const month = parseInt(ym.slice(5),10)

  return (
    <div className="space-y-3">
      <div className="flex items-center gap-2">
        <Button onClick={()=> setYM(prevMonth(ym))}>Mes anterior</Button>
        <div className="font-semibold">{ym}</div>
        <Button onClick={()=> setYM(nextMonth(ym))}>Mes siguiente</Button>
        <select value={year} onChange={(e)=> setYM(`${e.target.value}-${String(month).padStart(2,'0')}`)} className="rounded-xl border px-2 py-1 text-sm">
          {Array.from({length: 6}).map((_,i)=>{
            const y = new Date().getFullYear() - 2 + i
            return <option value={y} key={y}>{y}</option>
          })}
        </select>
        <select value={month} onChange={(e)=> setYM(`${ym.slice(0,4)}-${String(e.target.value).padStart(2,'0')}`)} className="rounded-xl border px-2 py-1 text-sm">
          {Array.from({length:12}).map((_,i)=> <option key={i+1} value={i+1}>{i+1}</option>)}
        </select>
      </div>

      <div className="grid grid-cols-7 gap-2">
        {days.map(d=> {
          const key = d.toISOString().slice(0,10)
          const list = eventsByDay[key] || []
          return (
            <div key={key} className="min-h-[110px] rounded-2xl border p-2">
              <div className="text-xs text-neutral-500">{key}</div>
              <div className="mt-1 space-y-1">
                {list.map((e,i)=> (
                  <button key={e.id+"-"+i} onClick={()=> onOpen(e)} className="block w-full text-left rounded-xl border px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10">
                    <div className="text-xs font-medium">{e.name}</div>
                    <div className="text-[11px] text-neutral-500">{e.megaEvent} · {e.venue}</div>
                  </button>
                ))}
              </div>
            </div>
          )
        })}
      </div>
    </div>
  )
}
