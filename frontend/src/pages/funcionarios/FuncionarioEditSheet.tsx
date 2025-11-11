import { useEffect, useMemo, useState } from 'react'
import { Button, Input, Sheet, SheetContent, SheetHeader, SheetTitle, Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@ui/index'
import { api } from '../../lib/api'
import { toast } from 'sonner'
import axios from 'axios'

type Puesto = { id:number, nombre:string, id_area:number, area:string }
type Usuario = {
  id: number
  nombreUsuario: string
  nombre?: string
  apellidoPaterno?: string
  apellidoMaterno?: string
  correo?: string
  telefono?: string
  celular?: string
  rfc?: string
  activo?: boolean
  id_puesto?: number
}

type Form = {
  nombre: string
  apellidoPaterno: string
  apellidoMaterno: string
  correo: string
  telefono: string
  celular: string
  rfc: string
  activo: boolean
  rol: 'funcionario' | 'administrador' | 'superadministrador'
}

export default function FuncionarioEditSheet({ usuario, onClose, onSaved }:{
  usuario: Usuario, onClose:()=>void, onSaved:()=>void
}){
  const [form,setForm] = useState<Form>({
    nombre: usuario?.nombre || '', apellidoPaterno: usuario?.apellidoPaterno || '', apellidoMaterno: usuario?.apellidoMaterno || '',
    correo: usuario?.correo || '', telefono: usuario?.telefono || '', celular: usuario?.celular || '', rfc: usuario?.rfc || '',
    activo: Boolean(usuario?.activo), rol: 'funcionario'
  })
  const [puestos,setPuestos] = useState<Puesto[]>([])
  const [q,setQ] = useState('')
  const [idPuesto,setIdPuesto] = useState<number|''>('')

  function set<K extends keyof Form>(k:K, v:Form[K]){ setForm(prev=>({...prev,[k]:v})) }

  async function loadPuestos(qStr?:string){
    const { data } = await api.get<Puesto[]>('/api/puestos', { params: { q: qStr || undefined } })
    setPuestos(data)
  }
  useEffect(()=>{ loadPuestos() }, [])
  useEffect(()=>{ const t=setTimeout(()=>loadPuestos(q),300); return ()=>clearTimeout(t) }, [q])

  const options = useMemo(()=>puestos.map(p=>({ value:String(p.id), label:`${p.area} — ${p.nombre}` })), [puestos])

  useEffect(()=>{
    if (usuario?.id_puesto) setIdPuesto(Number(usuario.id_puesto))
  }, [usuario])

  async function save(){
    try{
      await api.patch(`/api/usuarios/${usuario.id}`, { ...form, idPuesto: idPuesto || undefined })
      toast.success('Cambios guardados')
      onSaved()
    }catch(err: unknown){
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al guardar' : 'Error al guardar'
      toast.error(msg)
    }
  }
  async function activar(v:boolean){
    try{
      await api.post(`/api/usuarios/${usuario.id}/${v?'activar':'desactivar'}`)
      toast.success(v?'Usuario activado':'Usuario desactivado')
      onSaved()
    }catch{ toast.error('Error al cambiar estado') }
  }

  return (
    <Sheet>
      <SheetContent>
        <SheetHeader><SheetTitle>Editar funcionario</SheetTitle></SheetHeader>
        <div className="space-y-3 mt-2">
          <div className="text-sm text-gray-600">Usuario: <b>{usuario?.nombreUsuario}</b></div>

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

          <div className="grid grid-cols-2 gap-2">
            <div>
              <label className="text-sm">Rol</label>
              <Select value={form.rol} onValueChange={(v:'funcionario'|'administrador'|'superadministrador')=>set('rol', v)}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="funcionario">Funcionario</SelectItem>
                  <SelectItem value="administrador">Administrador</SelectItem>
                  <SelectItem value="superadministrador">Superadministrador</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <label className="text-sm inline-flex items-center gap-2">
              <input
                type="checkbox"
                checked={form.activo}
                onChange={(ev: React.ChangeEvent<HTMLInputElement>)=>set('activo', ev.target.checked)}
              /> Activo
            </label>
          </div>

          <div className="flex justify-between pt-2">
            <Button variant="outline" onClick={()=>activar(!usuario?.activo)}>{usuario?.activo ? 'Desactivar' : 'Activar'}</Button>
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
