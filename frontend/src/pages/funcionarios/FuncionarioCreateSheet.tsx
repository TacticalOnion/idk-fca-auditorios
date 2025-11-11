import { useEffect, useMemo, useState } from 'react'
import { Button, Input, Sheet, SheetContent, SheetHeader, SheetTitle, Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@ui/index'
import { api } from '../../lib/api'
import { toast } from 'sonner'
import axios from 'axios'

type Puesto = { id:number, nombre:string, id_area:number, area:string }

type Form = {
  nombreUsuario: string
  nombre: string
  apellidoPaterno: string
  apellidoMaterno: string
  correo: string
  telefono: string
  celular: string
  rfc: string
  contrasenia: string
}

export default function FuncionarioCreateSheet({ onClose, onCreated }:{ onClose:()=>void, onCreated:()=>void }){
  const [form,setForm] = useState<Form>({ nombreUsuario:'', nombre:'', apellidoPaterno:'', apellidoMaterno:'', correo:'', telefono:'', celular:'', rfc:'', contrasenia:'' })
  const [puestos,setPuestos] = useState<Puesto[]>([])
  const [q,setQ] = useState('')
  const [idPuesto,setIdPuesto] = useState<number|''>('')

  function set<K extends keyof Form>(k:K, v:Form[K]){ setForm(prev=>({...prev,[k]:v})) }

  async function loadPuestos(qStr?:string){
    const { data } = await api.get<Puesto[]>('/api/puestos', { params: { q: qStr || undefined } })
    setPuestos(data)
  }
  useEffect(()=>{ loadPuestos() }, [])
  useEffect(()=>{ const t = setTimeout(()=>loadPuestos(q), 300); return ()=>clearTimeout(t) }, [q])

  const options = useMemo(()=>puestos.map(p=>({ value:String(p.id), label:`${p.area} — ${p.nombre}` })), [puestos])

  async function submit(){
    try{
      if (!idPuesto) { toast.error('Selecciona un puesto'); return }
      await api.post('/api/usuarios', { ...form, rol:'funcionario', idPuesto: Number(idPuesto) })
      toast.success('Funcionario creado')
      onCreated()
    }catch(err: unknown){
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al crear' : 'Error al crear'
      toast.error(msg)
    }
  }

  return (
    <Sheet>
      <SheetContent>
        <SheetHeader><SheetTitle>Nuevo funcionario</SheetTitle></SheetHeader>
        <div className="space-y-3 mt-2">
          <div><label className="text-sm">Usuario</label><Input value={form.nombreUsuario} onChange={e=>set('nombreUsuario', e.target.value)} /></div>

          {/* Puesto */}
          <div className="grid grid-cols-[1fr,auto] gap-2">
            <div>
              <label className="text-sm">Puesto</label>
              <Select value={String(idPuesto)} onValueChange={(v:string)=>setIdPuesto(v ? Number(v) : '')}>
                <SelectTrigger><SelectValue placeholder="— Selecciona —" /></SelectTrigger>
                <SelectContent>
                  {options.map(o=> <SelectItem key={o.value} value={o.value}>{o.label}</SelectItem>)}
                </SelectContent>
              </Select>
            </div>
            <div>
              <label className="text-sm">Buscar</label>
              <Input placeholder="Filtrar puestos..." value={q} onChange={e=>setQ(e.target.value)} />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-2">
            <div><label className="text-sm">Nombre</label><Input value={form.nombre} onChange={e=>set('nombre', e.target.value)} /></div>
            <div><label className="text-sm">RFC</label><Input value={form.rfc} onChange={e=>set('rfc', e.target.value)} /></div>
          </div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className="text-sm">Apellido paterno</label><Input value={form.apellidoPaterno} onChange={e=>set('apellidoPaterno', e.target.value)} /></div>
            <div><label className="text-sm">Apellido materno</label><Input value={form.apellidoMaterno} onChange={e=>set('apellidoMaterno', e.target.value)} /></div>
          </div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className="text-sm">Correo</label><Input value={form.correo} onChange={e=>set('correo', e.target.value)} /></div>
            <div><label className="text-sm">Teléfono</label><Input value={form.telefono} onChange={e=>set('telefono', e.target.value)} /></div>
          </div>
          <div><label className="text-sm">Celular</label><Input value={form.celular} onChange={e=>set('celular', e.target.value)} /></div>
          <div><label className="text-sm">Contraseña inicial</label><Input type="password" value={form.contrasenia} onChange={e=>set('contrasenia', e.target.value)} placeholder="(opcional, default 'changeme')"/></div>

          <div className="flex justify-end gap-2 pt-2">
            <Button variant="ghost" onClick={onClose}>Cerrar</Button>
            <Button onClick={submit} disabled={!form.nombreUsuario || !idPuesto}>Guardar</Button>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  )
}
