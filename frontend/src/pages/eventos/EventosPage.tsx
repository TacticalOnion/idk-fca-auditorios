import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Button, Card, CardContent, CardHeader, CardTitle, Input, Table, TBody, TD, TH, THead, TR, Tabs, TabsList, TabsTrigger, TabsContent } from '@ui/index'
import { useMemo, useState } from 'react'
import { toast } from 'sonner'
import { Download, Search, Plus } from 'lucide-react'
import KanbanView from './KanbanView'
import CalendarView from './CalendarView'
import CreateEventSheet from '@/components/CreateEventSheet'
import EventDetailSheet from './EventDetailSheet'
import type { Evento } from '../../types'
import axios from 'axios'

export default function EventosPage(){
  const qc = useQueryClient()
  const { data } = useQuery({ queryKey:['eventos'], queryFn: async ()=> (await api.get<Evento[]>('/api/eventos')).data })
  const [q,setQ] = useState('')
  const [estatus,setEstatus] = useState<string>('')
  const [openDetail,setOpenDetail] = useState(false)
  const [selId,setSelId] = useState<number| null>(null)
  const [openCreate,setOpenCreate] = useState(false)

  const filtered = useMemo(()=> (data||[])
    .filter(e=> e.nombre?.toLowerCase().includes(q.toLowerCase()))
    .filter(e=> !estatus || e.estatus===estatus), [data,q,estatus])

  function openDetailSheet(ev:Evento){ setSelId(ev.id); setOpenDetail(true) }

  const verificar = useMutation({
    mutationFn: async (id:number)=> (await api.get<Array<{ faltante:number; nombre_equipamiento:string }>>(`/api/eventos/${id}/verificar-equipamiento`)).data,
    onSuccess: (rows)=> {
      if (!rows?.length) { toast.success('Sin requerimientos registrados'); return }
      const faltantes = rows.filter((r)=> Number(r.faltante)>0)
      if (faltantes.length===0) toast.success('Equipamiento suficiente')
      else toast.warning('Equipamiento insuficiente: ' + faltantes.map((x)=>x.nombre_equipamiento).join(', '))
    },
    onError: (err: unknown)=> toast.error(axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al verificar' : 'Error al verificar')
  })

  const autorizar = useMutation({
    mutationFn: async (id:number)=> (await api.post(`/api/eventos/${id}/autorizar`)).data,
    onSuccess: ()=>{ toast.success('Evento autorizado'); qc.invalidateQueries({queryKey:['eventos']}) },
    onError: (err: unknown)=> toast.error(axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'No se puede autorizar' : 'No se puede autorizar')
  })
  const cancelar = useMutation({
    mutationFn: async ({id,motivo}:{id:number, motivo:string})=> (await api.post(`/api/eventos/${id}/cancelar`, null, { params:{motivo} })).data,
    onSuccess: ()=>{ toast.success('Evento cancelado'); qc.invalidateQueries({queryKey:['eventos']}) },
    onError: (err: unknown)=> toast.error(axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al cancelar' : 'Error al cancelar')
  })
  const deshacer = useMutation({
    mutationFn: async (id:number)=> (await api.post(`/api/eventos/${id}/deshacer`)).data,
    onSuccess: ()=>{ toast.success('Estatus revertido'); qc.invalidateQueries({queryKey:['eventos']}) },
    onError: ()=> toast.error('Error al revertir')
  })

  async function descargarZip(id:number){
    try{
      const res = await api.post(`/api/eventos/${id}/descargar-reconocimientos`, null, { responseType:'blob' })
      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a'); a.href=url; a.download = `reconocimientos_evento_${id}.zip`; a.click()
      URL.revokeObjectURL(url)
    }catch{ toast.error('No hay reconocimientos o error de descarga') }
  }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Eventos</CardTitle>
        <div className="flex gap-2 items-center">
          <Input placeholder="Buscar por nombre..." value={q} onChange={e=>setQ(e.target.value)} />
          <select className="border px-2 py-2 rounded-md text-sm" value={estatus} onChange={e=>setEstatus(e.target.value)}>
            <option value="">Todos</option>
            <option value="pendiente">Pendiente</option>
            <option value="autorizado">Autorizado</option>
            <option value="cancelado">Cancelado</option>
          </select>
          <Button onClick={()=>setOpenCreate(true)}><Plus size={16} className="mr-2" /> Nuevo</Button>
        </div>
      </CardHeader>
      <CardContent className="overflow-auto">
        <Tabs defaultValue="table">
          <TabsList>
            <TabsTrigger value="table">Tabla</TabsTrigger>
            <TabsTrigger value="kanban">Kanban</TabsTrigger>
            <TabsTrigger value="calendar">Calendario</TabsTrigger>
          </TabsList>

          {/* Tabla */}
          <TabsContent value="table">
            <Table>
              <THead><TR><TH>Nombre</TH><TH>Estatus</TH><TH>Fechas</TH><TH>Modalidad</TH><TH></TH></TR></THead>
              <TBody>
                {filtered.map(e=>(
                  <TR key={e.id}>
                    <TD>{e.nombre}</TD>
                    <TD>
                      {e.estatus==='autorizado' && <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">Autorizado</span>}
                      {e.estatus==='pendiente' && <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-yellow-100 text-yellow-800">Pendiente</span>}
                      {e.estatus==='cancelado' && <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800">Cancelado</span>}
                    </TD>
                    <TD>{e.fechaInicio} {e.horarioInicio} — {e.fechaFin} {e.horarioFin}</TD>
                    <TD>{e.presencial && 'Presencial'} {e.online && 'Online'}</TD>
                    <TD className="flex gap-2">
                      <Button variant="outline" onClick={()=>openDetailSheet(e)}>Ver</Button>
                      <Button variant="ghost" onClick={()=>verificar.mutate(e.id)} title="Verificar equipamiento"><Search size={16}/></Button>
                      <Button variant="ghost" onClick={()=>autorizar.mutate(e.id)} title="Autorizar">Autorizar</Button>
                      <Button variant="ghost" onClick={()=>cancelar.mutate({id:e.id, motivo:'No especificado'})} title="Cancelar">Cancelar</Button>
                      <Button variant="ghost" onClick={()=>deshacer.mutate(e.id)} title="Deshacer">Deshacer</Button>
                      <Button variant="ghost" onClick={()=>descargarZip(e.id)} title="Descargar reconocimientos"><Download size={16}/></Button>
                    </TD>
                  </TR>
                ))}
              </TBody>
            </Table>
          </TabsContent>

          {/* Kanban */}
          <TabsContent value="kanban">
            <KanbanView data={filtered}/>
          </TabsContent>

          {/* Calendario */}
          <TabsContent value="calendar">
            <CalendarView data={filtered}/>
          </TabsContent>
        </Tabs>
      </CardContent>

      {/* Detalle */}
      {openDetail && selId && (
        <EventDetailSheet id={selId} onClose={()=>{ setOpenDetail(false); setSelId(null) }}/>
      )}

      {/* Alta */}
      {openCreate && <CreateEventSheet onClose={()=>setOpenCreate(false)} onCreated={()=>{ setOpenCreate(false); qc.invalidateQueries({queryKey:['eventos']}) }}/>}
    </Card>
  )
}
