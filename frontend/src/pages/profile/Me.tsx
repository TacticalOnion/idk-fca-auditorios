import { useAuth } from '@/lib/useAuth'
import { Card, CardContent, CardHeader, CardTitle } from '@ui/index'

export default function MePage(){
  const { user } = useAuth()
  return (
    <Card>
      <CardHeader><CardTitle>Mi perfil</CardTitle></CardHeader>
      <CardContent className="space-y-2">
        <div><b>Usuario:</b> {user?.nombreUsuario}</div>
        <div><b>Nombre:</b> {user?.nombre} {user?.apellidoPaterno} {user?.apellidoMaterno}</div>
        <div><b>Correo:</b> {user?.correo}</div>
        <div><b>Teléfono:</b> {user?.telefono}</div>
        <div><b>Celular:</b>{user?.celular}</div>
        <div><b>RFC:</b> {user?.rfc}</div>
      </CardContent>
    </Card>
  )
}
