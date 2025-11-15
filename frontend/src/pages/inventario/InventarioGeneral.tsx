import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Card, CardContent, CardHeader, CardTitle, Table, THead, TR, TH, TBody, TD, Input } from '@ui/index'
import { useMemo, useState } from 'react'

type PorArea   = { area:string; cantidad:number }
type PorRecinto= { recinto:string; cantidad:number }
type Row = { id:number, nombre:string, existencia:boolean, total:number, porArea:PorArea[], porRecinto:PorRecinto[] }

function Pill({ ok }:{ ok:boolean }) {
  return ok
    ? <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">Sí</span>
    : <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800">No</span>
}

export default function InventarioGeneral(){
  const { data } = useQuery({ queryKey:['inv-general'], queryFn: async ()=> (await api.get<Row[]>('/api/inventario/general')).data })
  const [q,setQ] = useState('')
  const rows = useMemo(()=> (data||[]).filter(r=>r.nombre.toLowerCase().includes(q.toLowerCase())), [data,q])

  return (
    <Card>
      <CardHeader className="flex justify-between items-center"><CardTitle>Inventario (General)</CardTitle><Input placeholder="Buscar equipamiento..." value={q} onChange={e=>setQ(e.target.value)}/></CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR><TH>Equipamiento</TH><TH>Existencia</TH><TH>Total</TH><TH>Por área</TH><TH>Por recinto</TH></TR></THead>
          <TBody>
            {rows.map(r=>(
              <TR key={r.id}>
                <TD>{r.nombre}</TD>
                <TD><Pill ok={r.existencia} /></TD>
                <TD>{r.total}</TD>
                <TD>{r.porArea?.map((x,i)=><div key={i}>{x.area}: {x.cantidad}</div>)}</TD>
                <TD>{r.porRecinto?.map((x,i)=><div key={i}>{x.recinto}: {x.cantidad}</div>)}</TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}
