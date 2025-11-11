import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Button, Card, CardContent, CardHeader, CardTitle, Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, Input, Table, THead, TR, TH, TBody, TD } from '@ui/index'
import { useState } from 'react'
import { toast } from 'sonner'
import type { Calendario } from '../../types'
import axios from 'axios'

export default function CalendarioPage(){
  const qc = useQueryClient()
  const { data } = useQuery({
    queryKey:['calendario'],
    queryFn: async ()=> (await api.get<Calendario[]>('/api/calendario')).data
  })
  const [open,setOpen] = useState(false)
  const [semestre,setSemestre] = useState('')
  const [semInicio,setSemInicio] = useState('')
  const [semFin,setSemFin] = useState('')
  const [periodos,setPeriodos] = useState<Array<{idTipoPeriodo:string, fechaInicio:string, fechaFin:string}>>([])

  const create = useMutation({
    mutationFn: async ()=>{
      await api.post('/api/calendario',{ semestre, semestreInicio:semInicio, semestreFin:semFin, periodos })
    },
    onSuccess: ()=>{ toast.success('Calendario creado'); setOpen(false); qc.invalidateQueries({queryKey:['calendario']}) },
    onError: (err: unknown)=>{
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error' : 'Error'
      toast.error(msg)
    }
  })

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Calendario escolar</CardTitle>
        <Button onClick={()=>setOpen(true)}>Nuevo</Button>
      </CardHeader>
      <CardContent>
        <Table>
          <THead><TR><TH>Semestre</TH><TH>Inicio</TH><TH>Fin</TH><TH>Periodos</TH></TR></THead>
          <TBody>
            {data?.map((c:Calendario)=>(
              <TR key={c.id}>
                <TD>{c.semestre}</TD><TD>{c.semestreInicio}</TD><TD>{c.semestreFin}</TD>
                <TD>{c.periodos?.length || 0}</TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>

      {open && (
        <Dialog>
          <DialogContent>
            <DialogHeader><DialogTitle>Nuevo calendario</DialogTitle></DialogHeader>
            <div className="p-4 space-y-3">
              <div><label className="text-sm">Semestre</label><Input value={semestre} onChange={e=>setSemestre(e.target.value)} /></div>
              <div className="grid grid-cols-2 gap-2">
                <div><label className="text-sm">Inicio</label><Input type="date" value={semInicio} onChange={e=>setSemInicio(e.target.value)} /></div>
                <div><label className="text-sm">Fin</label><Input type="date" value={semFin} onChange={e=>setSemFin(e.target.value)} /></div>
              </div>
              <div className="space-y-2">
                <div className="font-medium">Periodos</div>
                {periodos.map((p,idx)=>(
                  <div key={idx} className="grid grid-cols-[1fr,1fr,auto] gap-2">
                    <Input placeholder="idTipoPeriodo" value={p.idTipoPeriodo} onChange={e=>setPeriodos(prev=>prev.map((x,i)=>i===idx?{...x,idTipoPeriodo:e.target.value}:x))}/>
                    <div className="grid grid-cols-2 gap-2">
                      <Input type="date" value={p.fechaInicio} onChange={e=>setPeriodos(prev=>prev.map((x,i)=>i===idx?{...x,fechaInicio:e.target.value}:x))}/>
                      <Input type="date" value={p.fechaFin} onChange={e=>setPeriodos(prev=>prev.map((x,i)=>i===idx?{...x,fechaFin:e.target.value}:x))}/>
                    </div>
                    <Button variant="destructive" onClick={()=>setPeriodos(prev=>prev.filter((_,i)=>i!==idx))}>Quitar</Button>
                  </div>
                ))}
                <Button variant="outline" onClick={()=>setPeriodos(prev=>[...prev,{idTipoPeriodo:'',fechaInicio:'',fechaFin:''}])}>Agregar periodo</Button>
              </div>
            </div>
            <DialogFooter>
              <Button variant="ghost" onClick={()=>setOpen(false)}>Cerrar</Button>
              <Button onClick={()=>create.mutate()} disabled={!semestre||!semInicio||!semFin}>Guardar</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      )}
    </Card>
  )
}
