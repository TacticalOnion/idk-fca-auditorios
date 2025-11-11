import { useAuth } from '@/lib/useAuth'
import { Card, CardContent, CardHeader, CardTitle } from '@ui/index'

function Pill({ ok }:{ ok:boolean }) {
  return ok
    ? <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">Activo</span>
    : <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800">Inactivo</span>
}

export default function MePage(){
  const { user } = useAuth()
  return (
    <Card>
      <CardHeader><CardTitle>Mi perfil</CardTitle></CardHeader>
      <CardContent className="space-y-2">
        <div><b>Usuario:</b> {user?.nombreUsuario}</div>
        <div><b>Nombre:</b> {user?.nombre} {user?.apellidoPaterno} {user?.apellidoMaterno}</div>
        <div><b>Correo:</b> {user?.correo}</div>
        <div><b>Teléfono:</b> {user?.telefono} / {user?.celular}</div>
        <div><b>RFC:</b> {user?.rfc}</div>
        <div><b>Activo:</b> <Pill ok={Boolean(user?.activo)} /></div>
      </CardContent>
    </Card>
  )
}
