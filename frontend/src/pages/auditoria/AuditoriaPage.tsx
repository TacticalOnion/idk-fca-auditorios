import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Card, CardContent, CardHeader, CardTitle, Table, THead, TR, TH, TBody, TD } from '@ui/index'

type Row = {
  nombre_tabla: string
  id_registro_afectado: number
  accion: string
  campo_modificado: string
  valor_anterior: string
  valor_nuevo: string
  fecha_hora: string
  id_usuario: number
  id_puesto: number
}

export default function AuditoriaPage(){
  const { data } = useQuery({ queryKey: ['auditoria'], queryFn: async ()=> (await api.get<Row[]>('/api/auditoria')).data })
  return (
    <Card>
      <CardHeader><CardTitle>Registro auditoría</CardTitle></CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR>
            <TH>Tabla</TH><TH>ID</TH><TH>Acción</TH><TH>Campo</TH><TH>Antes</TH><TH>Después</TH><TH>Fecha</TH><TH>Usuario</TH><TH>Puesto</TH>
          </TR></THead>
          <TBody>
            {data?.map((r,i)=>(
              <TR key={i}>
                <TD>{r.nombre_tabla}</TD><TD>{r.id_registro_afectado}</TD><TD>{r.accion}</TD>
                <TD>{r.campo_modificado}</TD><TD>{r.valor_anterior}</TD><TD>{r.valor_nuevo}</TD>
                <TD>{new Date(r.fecha_hora).toLocaleString()}</TD><TD>{r.id_usuario}</TD><TD>{r.id_puesto}</TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}
