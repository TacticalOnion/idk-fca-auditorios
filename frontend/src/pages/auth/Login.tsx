import { useState } from 'react'
import { Button, Card, CardContent, CardHeader, CardTitle, Input } from '@ui/index'
import { useAuth } from '@/lib/useAuth'
import { toast } from 'sonner'
import { useNavigate } from 'react-router-dom'
import axios from 'axios'

export default function LoginPage(){
  const { login } = useAuth()
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const nav = useNavigate()

  async function onSubmit(e: React.FormEvent){
    e.preventDefault()
    try {
      await login(username, password)
      toast.success('Bienvenido')
      nav('/', { replace: true })
    } catch (err: unknown) {
      const msg =
        axios.isAxiosError(err)
          ? (err.response?.data as { message?: string })?.message ?? 'Credenciales inválidas'
          : 'Credenciales inválidas'
      toast.error(msg)
    }
  }

  return (
    <div className="min-h-screen grid place-items-center">
      <Card className="w-full max-w-sm">
        <CardHeader><CardTitle>Iniciar sesión</CardTitle></CardHeader>
        <CardContent>
          <form className="space-y-3" onSubmit={onSubmit}>
            <div><label className="text-sm">Usuario</label><Input value={username} onChange={e=>setUsername(e.target.value)} required/></div>
            <div><label className="text-sm">Contraseña</label><Input type="password" value={password} onChange={e=>setPassword(e.target.value)} required/></div>
            <Button type="submit" className="w-full">Entrar</Button>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}
