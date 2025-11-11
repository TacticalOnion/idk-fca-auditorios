import { Button } from '@ui/index'
import { Download, Search } from 'lucide-react'
import { api } from '../../lib/api'
import { toast } from 'sonner'
import type { Evento } from '../../types'
import axios from 'axios'

type Props = { data: Evento[] }

function CountPill({ children }:{ children: React.ReactNode }){
  return <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-neutral-100 text-neutral-800">{children}</span>
}

export default function KanbanView({ data }: Props) {
  const cols = [
    { key:'pendiente' as const,  title:'Pendiente'  },
    { key:'autorizado' as const, title:'Autorizado' },
    { key:'cancelado' as const,  title:'Cancelado'  },
  ]

  async function verificar(id:number){
    try{
      const rows = (await api.get<Array<{ faltante:number; nombre_equipamiento:string }>>(`/api/eventos/${id}/verificar-equipamiento`)).data
      const faltantes = rows.filter((r)=> Number(r.faltante)>0)
      if (faltantes.length===0) toast.success('Equipamiento suficiente')
      else toast.warning('Faltan: ' + faltantes.map((x)=>x.nombre_equipamiento).join(', '))
    } catch (err: unknown) {
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al verificar' : 'Error al verificar'
      toast.error(msg)
    }
  }

  async function descargar(id:number){
    try{
      const res = await api.post(`/api/eventos/${id}/descargar-reconocimientos`, null, { responseType:'blob' })
      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a'); a.href=url; a.download=`reconocimientos_evento_${id}.zip`; a.click()
      URL.revokeObjectURL(url)
    }catch{ toast.error('No hay reconocimientos o error') }
  }

  return (
    <div className="grid md:grid-cols-3 gap-4">
      {cols.map(c=>(
        <div key={c.key} className="bg-white border rounded-lg p-3">
          <div className="flex items-center justify-between mb-3">
            <div className="font-semibold">{c.title}</div>
            <CountPill>{data.filter(d=>d.estatus===c.key).length}</CountPill>
          </div>
            <div className="space-y-2">
              {data.filter(d=>d.estatus===c.key).map(card=>(
                <div key={card.id} className="border rounded-md p-3 bg-neutral-50">
                  <div className="font-medium">{card.nombre}</div>
                  <div className="text-xs text-gray-600">{card.fechaInicio} {card.horarioInicio} — {card.fechaFin} {card.horarioFin}</div>
                  <div className="flex gap-2 mt-2">
                    <Button variant="ghost" onClick={()=>verificar(card.id)} title="Verificar"><Search size={16}/></Button>
                    <Button variant="ghost" onClick={()=>descargar(card.id)} title="Descargar ZIP"><Download size={16}/></Button>
                  </div>
                </div>
              ))}
            </div>
        </div>
      ))}
    </div>
  )
}
