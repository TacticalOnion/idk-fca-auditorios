import { useState } from 'react'
import { Button, Input, Sheet, SheetContent, SheetHeader, SheetTitle } from '@ui/index'
import { api } from '../../lib/api'
import { toast } from 'sonner'
import axios from 'axios'

export type Recinto = {
  id: number
  nombre: string
  capacidad?: number | null
  ubicacion?: string
  croquis?: string
  activo?: boolean
}

export default function RecintoEditSheet({ recinto, onClose, onSaved }:{
  recinto: Recinto, onClose:()=>void, onSaved:()=>void
}) {
  const [nombre,setNombre] = useState(recinto?.nombre || '')
  const [capacidad,setCapacidad] = useState(String(recinto?.capacidad ?? ''))
  const [ubicacion,setUbicacion] = useState(recinto?.ubicacion || '')
  const [croquis,setCroquis] = useState(recinto?.croquis || '')
  const [activo,setActivo] = useState(Boolean(recinto?.activo ?? true))

  async function save(){
    try{
      await api.patch(`/api/recintos/${recinto.id}`, {
        nombre, capacidad: capacidad? Number(capacidad): null, ubicacion, croquis, activo
      })
      toast.success('Recinto actualizado')
      onSaved()
    }catch(err: unknown){
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al guardar' : 'Error al guardar'
      toast.error(msg)
    }
  }

  async function remove(){
    if (!confirm('¿Eliminar (baja lógica) este recinto?')) return
    try{
      await api.delete(`/api/recintos/${recinto.id}`)
      toast.success('Recinto eliminado')
      onSaved()
    }catch(err: unknown){
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al eliminar' : 'Error al eliminar'
      toast.error(msg)
    }
  }

  return (
    <Sheet>
      <SheetContent>
        <SheetHeader><SheetTitle>Editar recinto</SheetTitle></SheetHeader>
        <div className="space-y-3 mt-2">
          <div><label className="text-sm">Nombre</label><Input value={nombre} onChange={e=>setNombre(e.target.value)} /></div>
          <div><label className="text-sm">Capacidad</label><Input type="number" value={capacidad} onChange={e=>setCapacidad(e.target.value)} /></div>
          <div><label className="text-sm">Ubicación</label><Input value={ubicacion} onChange={e=>setUbicacion(e.target.value)} /></div>
          <div><label className="text-sm">Croquis (ruta)</label><Input value={croquis} onChange={e=>setCroquis(e.target.value)} /></div>
          <label className="text-sm inline-flex items-center gap-2"><input type="checkbox" checked={activo} onChange={e=>setActivo(e.target.checked)} /> Activo</label>
          <div className="flex justify-between pt-2">
            <Button variant="destructive" onClick={remove}>Eliminar</Button>
            <div className="flex gap-2">
              <Button variant="ghost" onClick={onClose}>Cerrar</Button>
              <Button onClick={save}>Guardar</Button>
            </div>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  )
}
