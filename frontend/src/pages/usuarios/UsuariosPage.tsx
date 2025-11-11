import { useMutation, useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Button, Card, CardContent, CardHeader, CardTitle, Input, Table, TBody, TD, TH, THead, TR } from '@ui/index'
import { useMemo, useState } from 'react'
import { toast } from 'sonner'
import axios from 'axios'

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

export default function UsuariosPage(){
  const [q,setQ] = useState('')

  const query = useQuery({
    queryKey:['usuarios'],
    queryFn: async ()=> (await api.get<Usuario[]>('/api/usuarios')).data,
    retry: false,
  })

  const rows = useMemo(()=> (query.data||[])
    .filter(u=> (u.nombreUsuario + ' ' + (u.nombre||'') + ' ' + (u.apellidoPaterno||'') + ' ' + (u.apellidoMaterno||''))
      .toLowerCase().includes(q.toLowerCase()))
  , [query.data,q])

  const reset = useMutation({
    mutationFn: async (id:number)=>{
      const nueva = prompt('Nueva contraseña (texto plano, se guarda como SHA-256)') || ''
      if (!nueva) throw new Error('Requerida')
      await api.post(`/api/usuarios/${id}/reset-password`, null, { params:{ nueva }})
    },
    onSuccess: ()=> toast.success('Contraseña actualizada'),
    onError: (err: unknown)=> {
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'No se pudo actualizar' : 'No se pudo actualizar'
      toast.error(msg)
    }
  })

  if (query.isError) {
    return (
      <Card>
        <CardHeader><CardTitle>Usuarios</CardTitle></CardHeader>
        <CardContent>
          <div className="text-sm text-red-700 bg-red-50 border border-red-200 rounded p-3">
            Endpoint <code>/api/usuarios</code> no disponible (pendiente en backend).
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Usuarios</CardTitle>
        <Input placeholder="Buscar..." value={q} onChange={e=>setQ(e.target.value)} />
      </CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR><TH>Usuario</TH><TH>Nombre</TH><TH>Correo</TH><TH>Rol</TH><TH>Activo</TH><TH></TH></TR></THead>
          <TBody>
            {rows.map(u=>(
              <TR key={u.id}>
                <TD>{u.nombreUsuario}</TD>
                <TD>{u.nombre} {u.apellidoPaterno} {u.apellidoMaterno}</TD>
                <TD>{u.correo}</TD>
                <TD>{typeof u.rol === 'string' ? u.rol : u.rol?.nombre}</TD>
                <TD><Pill ok={Boolean(u.activo)} /></TD>
                <TD><Button variant="outline" onClick={()=>reset.mutate(u.id)}>Reset contraseña</Button></TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}
