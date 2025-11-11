import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Card, CardContent, CardHeader, CardTitle, Table, THead, TR, TH, TBody, TD } from '@ui/index'

type Row = { recinto:string; equipamiento:string; cantidad:number; activo:boolean }

export default function InventarioRecinto(){
  const { data } = useQuery({ queryKey:['inv-recinto'], queryFn: async ()=> (await api.get<Row[]>('/api/inventario/recinto')).data })
  return (
    <Card>
      <CardHeader><CardTitle>Inventario por recinto</CardTitle></CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR><TH>Recinto</TH><TH>Equipamiento</TH><TH>Cantidad</TH><TH>Activo</TH></TR></THead>
          <TBody>
            {data?.map((r,i)=>(
              <TR key={i}><TD>{r.recinto}</TD><TD>{r.equipamiento}</TD><TD>{r.cantidad}</TD><TD>{String(r.activo)}</TD></TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}
