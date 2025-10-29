// src/kanban/KanbanBoard.tsx
import { useState } from 'react'
import { Card } from '@/components/ui/card'
import type { EventItem, Status } from '@/types/event'
import { EventBadges } from '@/components/events/EventBadges'
import { fmtDate, fmtTime } from '@/utils/date'

// shadcn/ui Dialog + Button + Textarea
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'

export function KanbanBoard({
  data, onOpen, onStatusChange
}:{
  data: {pendiente:EventItem[]; autorizado:EventItem[]; cancelado:EventItem[]}
  onOpen: (e:EventItem)=>void
  onStatusChange: (id:string, status: Status, opts?: { cancelReason?: string; clearCancelReason?: boolean })=>void
}){
  const columns: {key: keyof typeof data; title:string}[] = [
    {key:'pendiente', title:'Pendiente'},
    {key:'autorizado', title:'Autorizado'},
    {key:'cancelado', title:'Cancelado'},
  ]
  const color = (k:keyof typeof data)=> k==='pendiente'? 'border-yellow-300' : k==='autorizado'? 'border-green-300' : 'border-red-300'

  // Estado para el diálogo de cancelación
  const [cancelDialog, setCancelDialog] = useState<{open:boolean; eventId:string|null; reason:string}>({
    open:false, eventId:null, reason:''
  })
  const openCancel = (id:string)=>{
    setCancelDialog({open:true, eventId:id, reason:''})
  }
  const closeCancel = ()=> setCancelDialog({open:false, eventId:null, reason:''})
  const confirmCancel = ()=>{
    if (!cancelDialog.reason.trim() || !cancelDialog.eventId) return
    onStatusChange(cancelDialog.eventId, 'Cancelado', { cancelReason: cancelDialog.reason.trim() })
    closeCancel()
  }

  return (
    <>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        {columns.map(col=> (
          <div key={col.key} className={`rounded-2xl border ${color(col.key)} p-2 bg-neutral-50 dark:bg-neutral-950`}>
            <h3 className="px-2 py-2 font-semibold">{col.title}</h3>
            <div className="space-y-2">
              {data[col.key].map(e=> (
                <Card key={e.id} className="cursor-pointer" onClick={()=> onOpen(e)}>
                  <div className="space-y-1 p-2">
                    <div className="font-medium">{e.name}</div>
                    <EventBadges e={e} />
                    <div className="text-xs text-neutral-500">
                      {fmtDate(e.startDate)} - {fmtDate(e.endDate)} · {fmtTime(e.startTime)} - {fmtTime(e.endTime)}
                    </div>

                    {/* Acciones contextuales */}
                    <div className="flex gap-3 pt-2">
                      {e.status === 'Pendiente' ? (
                        <>
                          <button
                            onClick={(ev)=> {ev.stopPropagation(); onStatusChange(e.id, 'Autorizado')}}
                            className="text-xs underline"
                          >
                            Autorizar
                          </button>
                          <button
                            onClick={(ev)=> {ev.stopPropagation(); openCancel(e.id)}}
                            className="text-xs underline text-red-600"
                          >
                            Cancelar
                          </button>
                        </>
                      ) : (
                        <button
                          onClick={(ev)=> {ev.stopPropagation(); onStatusChange(e.id, 'Pendiente', { clearCancelReason: true })}}
                          className="text-xs underline"
                        >
                          deshacer
                        </button>
                      )}
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        ))}
      </div>

      {/* Diálogo de cancelación */}
      <Dialog open={cancelDialog.open} onOpenChange={(open)=> !open ? closeCancel() : null}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Motivo de cancelación</DialogTitle>
          </DialogHeader>
          <div className="space-y-2">
            <Textarea
              placeholder="Describe el motivo..."
              value={cancelDialog.reason}
              onChange={(e)=> setCancelDialog(prev=> ({...prev, reason: e.target.value}))}
            />
            {!cancelDialog.reason.trim() && (
              <p className="text-xs text-red-600">El motivo es obligatorio para cancelar.</p>
            )}
          </div>
          <DialogFooter>
            <Button variant="secondary" onClick={closeCancel}>Cancelar</Button>
            <Button
              onClick={confirmCancel}
              disabled={!cancelDialog.reason.trim()}
            >
              Confirmar cancelación
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  )
}
