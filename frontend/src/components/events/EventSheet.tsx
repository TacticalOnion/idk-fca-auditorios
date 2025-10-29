import { Sheet } from '@/components/ui/sheet'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { Select, SelectItem } from '@/components/ui/select'
import type { EventItem, Status } from '@/types/event'
import { fmtDate, fmtTime } from '@/utils/date'
import { downloadFile } from '@/utils/download'

export function EventSheet({event, onClose, onStatusChange}:{event:EventItem|null; onClose:()=>void; onStatusChange:(status:Status)=>void}){
  if(!event) return null
  const e = event
  return (
    <Sheet open={!!event} onOpenChange={(v)=> !v && onClose()}>
      <div className="space-y-4">
        <div>
          <h3 className="text-xl font-semibold">{e.name}</h3>
          <div className="mt-1 flex flex-wrap gap-1">
            <Badge className="bg-neutral-100">{e.megaEvent}</Badge>
            <Badge className="bg-neutral-100">{e.venue}</Badge>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label>Estatus</Label>
            <div className="mt-1">
              <Select value={e.status} onValueChange={(v)=> onStatusChange(v as Status)}>
                <SelectItem value="Pendiente">Pendiente</SelectItem>
                <SelectItem value="Autorizado">Autorizado</SelectItem>
                <SelectItem value="Cancelado">Cancelado</SelectItem>
              </Select>
            </div>
          </div>
          <div>
            <Label>Solicitud</Label>
            <div className="mt-1 text-sm">{fmtDate(e.requestedAt)}</div>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label>Fecha</Label>
            <div className="mt-1 text-sm">{fmtDate(e.startDate)} - {fmtDate(e.endDate)}</div>
          </div>
          <div>
            <Label>Horario</Label>
            <div className="mt-1 text-sm">{fmtTime(e.startTime)} - {fmtTime(e.endTime)}</div>
          </div>
        </div>

        <div>
          <Label>Modalidades & Categoría</Label>
          <div className="mt-1 flex flex-wrap gap-1 text-sm">
            {e.modalities.map(m=> <Badge key={m} className="bg-blue-50">{m}</Badge>)}
            <Badge className="bg-purple-50">{e.category}</Badge>
          </div>
        </div>

        <div>
          <Label>Descripción</Label>
          <p className="mt-1 text-sm leading-relaxed">{e.description}</p>
        </div>

        {e.status==='Cancelado' && e.cancelReason && (
          <div>
            <Label>Motivo</Label>
            <p className="mt-1 text-sm">{e.cancelReason}</p>
          </div>
        )}

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label>Organizadores</Label>
            <ul className="mt-1 text-sm list-disc list-inside">
              {e.organizers.map((p,i)=> <li key={i}>{p.name}</li>)}
            </ul>
          </div>
          <div>
            <Label>Participantes</Label>
            <ul className="mt-1 text-sm list-disc list-inside">
              {e.participants.map((p,i)=> (
                <li key={i}>
                  {p.profileUrl? <a className="underline" href={p.profileUrl} target="_blank" rel="noreferrer">{p.name}</a> : p.name}
                </li>
              ))}
            </ul>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <Button onClick={()=>{
            const semblanzas = e.participants.map(p=> ({name:p.name, url:p.semblanzaUrl||p.profileUrl||''}))
            const content = JSON.stringify(semblanzas, null, 2)
            downloadFile(`semblanzas_evento_${e.id}.json`, content, 'application/json')
          }}>Descargar semblanzas</Button>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label>Equipamiento</Label>
            <ul className="mt-1 text-sm list-disc list-inside">
              {e.equipment.map((it,i)=> <li key={i}>{it.name} × {it.quantity}</li>)}
            </ul>
          </div>
          <div>
            <Label>Áreas involucradas</Label>
            <ul className="mt-1 text-sm list-disc list-inside">
              {e.areas.map((a,i)=> <li key={i}>{a}</li>)}
            </ul>
          </div>
        </div>
      </div>
    </Sheet>
  )
}
