import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Card, CardContent, CardHeader, CardTitle, Table, THead, TR, TH, TBody, TD } from '@ui/index'

type Row = { area:string; equipamiento:string; cantidad:number; activo:boolean }

export default function InventarioArea(){
  const { data } = useQuery({ queryKey:['inv-area'], queryFn: async ()=> (await api.get<Row[]>('/api/inventario/area')).data })
  return (
    <Card>
      <CardHeader><CardTitle>Inventario por área</CardTitle></CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR><TH>Área</TH><TH>Equipamiento</TH><TH>Cantidad</TH><TH>Activo</TH></TR></THead>
          <TBody>
            {data?.map((r,i)=>(
              <TR key={i}><TD>{r.area}</TD><TD>{r.equipamiento}</TD><TD>{r.cantidad}</TD><TD>{String(r.activo)}</TD></TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}
