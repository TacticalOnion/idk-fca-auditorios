import { useState } from 'react'
import { Button, Input, Sheet, SheetContent, SheetHeader, SheetTitle } from '@ui/index'
import { toast } from 'sonner'
import { api } from '@/lib/api'
import axios from 'axios' // ⬅️ importa axios para usar el type-guard

type ApiErrorData = { message?: string }

export default function CreateEventSheet({ onClose, onCreated }:{ onClose:()=>void, onCreated:()=>void }){
  const [nombre,setNombre] = useState('')
  const [fechaInicio,setFechaInicio] = useState(''); const [horarioInicio,setHorarioInicio] = useState('')
  const [fechaFin,setFechaFin] = useState(''); const [horarioFin,setHorarioFin] = useState('')
  const [presencial,setPresencial] = useState(true); const [online,setOnline] = useState(false)

  async function submit(){
    try{
      await api.post('/api/eventos', {
        nombre, fechaInicio, fechaFin, horarioInicio, horarioFin, presencial, online, estatus:'pendiente'
      })
      toast.success('Evento creado')
      onCreated()
    } catch (err: unknown) {
      const msg = axios.isAxiosError(err)
        ? (err.response?.data as ApiErrorData | undefined)?.message ?? 'Endpoint de creación no disponible (pendiente en backend)'
        : 'Endpoint de creación no disponible (pendiente en backend)'
      toast.error(msg)
    }
  }

  return (
    <Sheet>
      <SheetContent>
        <SheetHeader><SheetTitle>Nuevo evento</SheetTitle></SheetHeader>
        <div className="space-y-3 mt-2">
          <div><label className="text-sm">Nombre</label><Input value={nombre} onChange={e=>setNombre(e.target.value)} /></div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className="text-sm">Fecha inicio</label><Input type="date" value={fechaInicio} onChange={e=>setFechaInicio(e.target.value)} /></div>
            <div><label className="text-sm">Fecha fin</label><Input type="date" value={fechaFin} onChange={e=>setFechaFin(e.target.value)} /></div>
          </div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className="text-sm">Hora inicio</label><Input type="time" value={horarioInicio} onChange={e=>setHorarioInicio(e.target.value)} /></div>
            <div><label className="text-sm">Hora fin</label><Input type="time" value={horarioFin} onChange={e=>setHorarioFin(e.target.value)} /></div>
          </div>
          <div className="flex items-center gap-4">
            <label className="text-sm inline-flex items-center gap-2"><input type="checkbox" checked={presencial} onChange={e=>setPresencial(e.target.checked)} /> Presencial</label>
            <label className="text-sm inline-flex items-center gap-2"><input type="checkbox" checked={online} onChange={e=>setOnline(e.target.checked)} /> Online</label>
          </div>
          <div className="flex justify-end gap-2 pt-2">
            <Button variant="ghost" onClick={onClose}>Cerrar</Button>
            <Button onClick={submit} disabled={!nombre || !fechaInicio || !fechaFin}>Guardar</Button>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  )
}
