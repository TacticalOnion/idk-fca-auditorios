import { useMemo, useState } from 'react'
import type { EventItem, Status } from '@/types/event'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { Table, TableHead, TableBody, TableRow, TableHeader, TableCell } from '@/components/ui/table'

import { ColumnToggle } from './ColumnToggle'
import { downloadFile, toCSV } from '@/utils/download'
import { fmtDate, fmtTime } from '@/utils/date'

const ALL_COLUMNS = [
  { key:'name', label:'Nombre' },
  { key:'megaEvent', label:'Mega evento' },
  { key:'venue', label:'Recinto' },
  { key:'status', label:'Estatus' },
  { key:'dates', label:'Fecha inicio - fin' },
  { key:'times', label:'Horario inicio - fin' },
  { key:'modalities', label:'Modalidades' },
  { key:'category', label:'Categoría' },
  { key:'requestedAt', label:'Fecha solicitud' },
  { key:'description', label:'Descripción' },
  { key:'cancelReason', label:'Motivo (si cancelado)' },
  { key:'organizers', label:'Organizadores' },
  { key:'participants', label:'Participantes' },
  { key:'equipment', label:'Equipamiento' },
  { key:'areas', label:'Áreas' },
] as const

type ColumnKey = typeof ALL_COLUMNS[number]['key']

export function EventsTableView({
  events, onOpen, onBulkStatus
}:{events:EventItem[]; onOpen:(e:EventItem)=>void; onBulkStatus:(ids:string[], status:Status)=>void}){
  const [search, setSearch] = useState('')
  const [visible, setVisible] = useState<Record<string, boolean>>(
    () => Object.fromEntries(ALL_COLUMNS.map(c=> [c.key, true]))
  )
  const [selected, setSelected] = useState<Record<string, boolean>>({})
  const [statusFilter, setStatusFilter] = useState<Status | 'Todos'>('Todos')

  const filtered = useMemo(()=>{
    return events
      .filter(e=> e.name.toLowerCase().includes(search.toLowerCase()))
      .filter(e=> statusFilter==='Todos' || e.status===statusFilter)
  },[events, search, statusFilter])

  const columns = ALL_COLUMNS.map(c=> ({...c, visible: visible[c.key]}))
  const selections = useMemo(()=> Object.keys(selected).filter(id=> selected[id]), [selected])

  const exportSelected = ()=>{
    const rows = filtered.filter(e=> selections.includes(e.id)).map(e => ({
      id: e.id,
      nombre: e.name,
      mega_evento: e.megaEvent,
      recinto: e.venue,
      estatus: e.status,
      fecha: `${fmtDate(e.startDate)} - ${fmtDate(e.endDate)}`,
      horario: `${fmtTime(e.startTime)} - ${fmtTime(e.endTime)}`,
      modalidades: e.modalities.join('|'),
      categoria: e.category,
      fecha_solicitud: fmtDate(e.requestedAt),
      descripcion: e.description,
      motivo: e.cancelReason ?? '',
      organizadores: e.organizers.map(o=> o.name).join('|'),
      participantes: e.participants.map(p=> p.name).join('|'),
      equipamiento: e.equipment.map(eq=> `${eq.name} x${eq.quantity}`).join('|'),
      areas: e.areas.join('|'),
    }))
    downloadFile('eventos_seleccion.csv', toCSV(rows), 'text/csv')
  }

  // Helper para campos primitivos tipados (evitar any):
  function getPrimitive<K extends keyof EventItem>(ev: EventItem, k: K): string {
    const v = ev[k]
    return typeof v === 'string' ? v : String(v)
  }

  const renderCell = (
    key: ColumnKey | 'dates' | 'times' | 'modalities' | 'cancelReason' | 'organizers' | 'participants' | 'equipment' | 'areas',
    e: EventItem,
    open:()=>void
  ) => {
    switch(key){
      case 'name': return <button className="underline" onClick={open}>{e.name}</button>
      case 'dates': return `${fmtDate(e.startDate)} - ${fmtDate(e.endDate)}`
      case 'times': return `${e.startTime} - ${e.endTime}`
      case 'modalities': return e.modalities.join(', ')
      case 'organizers': return e.organizers.map(o=> o.name).join(', ')
      case 'participants': return e.participants.map(p=> p.name).join(', ')
      case 'equipment': return e.equipment.map(eq=> `${eq.name}×${eq.quantity}`).join(', ')
      case 'areas': return e.areas.join(', ')
      case 'cancelReason': return e.cancelReason ?? ''
      // Campos string/enum simples de EventItem:
      case 'megaEvent':
      case 'venue':
      case 'status':
      case 'category':
      case 'requestedAt':
      case 'description':
        return getPrimitive(e, key as keyof EventItem)
      default:
        return null
    }
  }

  const handleStatusFilterChange = (ev: React.ChangeEvent<HTMLSelectElement>) => {
    const value = ev.target.value as Status | 'Todos'
    setStatusFilter(value)
  }

  return (
    <div className="space-y-3">
      <div className="flex flex-col gap-2 md:flex-row md:items-center md:justify-between">
        <div className="flex gap-2 items-center">
          <Input
            placeholder="Buscar por nombre..."
            value={search}
            onChange={(e)=> setSearch(e.target.value)}
            className="w-64"
          />
          <select
            value={statusFilter}
            onChange={handleStatusFilterChange}
            className="rounded-xl border px-2 py-1 text-sm"
          >
            <option value="Todos">Todos</option>
            <option value="Pendiente">Pendiente</option>
            <option value="Autorizado">Autorizado</option>
            <option value="Cancelado">Cancelado</option>
          </select>
        </div>
        <div className="flex gap-2">
          <Button onClick={exportSelected} disabled={selections.length===0}>
            Descargar seleccionados ({selections.length})
          </Button>
          <Button onClick={()=> onBulkStatus(selections, 'Autorizado')} disabled={selections.length===0}>
            Marcar Autorizado
          </Button>
        </div>
      </div>

      <ColumnToggle
        columns={columns}
        onChange={(key, v)=> setVisible(prev=> ({...prev, [key]: v}))}
      />

      <div className="overflow-auto border rounded-2xl">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>
                <input
                  type="checkbox"
                  onChange={(e)=>{
                    const v = e.target.checked
                    const next: Record<string, boolean> = {}
                    filtered.forEach(ev=> { next[ev.id] = v })
                    setSelected(next)
                  }}
                />
              </TableHead>
              {columns.filter(c=> c.visible).map(c=> <TableHead key={c.key}>{c.label}</TableHead>)}
            </TableRow>
          </TableHeader>
          <TableBody>
            {filtered.map(e=> (
              <TableRow key={e.id}>
                <TableCell>
                  <input
                    type="checkbox"
                    checked={!!selected[e.id]}
                    onChange={(ev)=> setSelected(prev=> ({...prev, [e.id]: ev.target.checked}))}
                  />
                </TableCell>
                {columns.filter(c=> c.visible).map(c=> (
                  <TableCell key={c.key}>
                    {renderCell(c.key, e, ()=> onOpen(e))}
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  )
}
