import { useQuery, useQueryClient } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Button, Card, CardContent, CardHeader, CardTitle, Input, Table, TBody, TD, TH, THead, TR } from '@ui/index'
import { useMemo, useState, lazy, Suspense } from 'react'

type Usuario = {
  id: number
  nombreUsuario: string
  nombre?: string
  apellidoPaterno?: string
  apellidoMaterno?: string
  correo?: string
  activo?: boolean
  rol?: { nombre: string } | string
}

function Pill({ ok }:{ ok:boolean }) {
  return ok
    ? <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">Sí</span>
    : <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800">No</span>
}

// Imports dinámicos válidos
const FuncionarioCreateSheet = lazy(() => import('./FuncionarioCreateSheet'))
const FuncionarioEditSheet = lazy(() => import('./FuncionarioEditSheet'))

export default function FuncionariosPage(){
  const [q,setQ] = useState('')
  const [createOpen,setCreateOpen] = useState(false)
  const [sel,setSel] = useState<Usuario|null>(null)
  const qc = useQueryClient()

  const { data, isError } = useQuery({
    queryKey:['usuarios'],
    queryFn: async ()=> (await api.get<Usuario[]>('/api/usuarios')).data,
    retry:false
  })

  const rows = useMemo(()=> (data||[])
    .filter(u=>{
      const rolName = typeof u.rol === 'string' ? u.rol : (u.rol?.nombre || '')
      return rolName.toLowerCase() === 'funcionario'
    })
    .filter(u=> (u.nombreUsuario + ' ' + (u.nombre||'') + ' ' + (u.apellidoPaterno||'') + ' ' + (u.apellidoMaterno||''))
      .toLowerCase().includes(q.toLowerCase()))
  , [data,q])

  function refresh(){
    setCreateOpen(false); setSel(null)
    qc.invalidateQueries({queryKey:['usuarios']})
  }

  if (isError) {
    return (
      <Card>
        <CardHeader><CardTitle>Funcionarios</CardTitle></CardHeader>
        <CardContent>
          <div className="text-sm text-red-700 bg-red-50 border border-red-200 rounded p-3">
            Endpoint <code>/api/usuarios</code> no disponible.
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Funcionarios</CardTitle>
        <div className="flex gap-2 items-center">
          <Input placeholder="Buscar..." value={q} onChange={e=>setQ(e.target.value)} />
          <Button onClick={()=>setCreateOpen(true)}>Nuevo</Button>
        </div>
      </CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR><TH>Usuario</TH><TH>Nombre</TH><TH>Correo</TH><TH>Activo</TH><TH></TH></TR></THead>
          <TBody>
            {rows.map(u=>(
              <TR key={u.id}>
                <TD>{u.nombreUsuario}</TD>
                <TD>{u.nombre} {u.apellidoPaterno} {u.apellidoMaterno}</TD>
                <TD>{u.correo}</TD>
                <TD><Pill ok={Boolean(u.activo)} /></TD>
                <TD><Button variant="outline" onClick={()=>setSel(u)}>Editar</Button></TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>

      <Suspense fallback={null}>
        {createOpen && (
          <FuncionarioCreateSheet
            onClose={()=>setCreateOpen(false)}
            onCreated={refresh}
          />
        )}
        {sel && (
          <FuncionarioEditSheet
            usuario={sel}
            onClose={()=>setSel(null)}
            onSaved={refresh}
          />
        )}
      </Suspense>
    </Card>
  )
}
