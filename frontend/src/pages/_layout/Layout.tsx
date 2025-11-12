import { NavLink, Outlet, useNavigate } from 'react-router-dom'
import { Button } from '@ui/index'
import { useAuth } from '@/lib/useAuth'
import { logout } from '@/lib/logout'

function Sidebar() {
  const link = ({ isActive }: { isActive: boolean }) =>
    `block px-3 py-2 rounded-md ${
      isActive ? 'bg-primary text-white' : 'text-gray-700 hover:bg-gray-100'
    }`

  return (
    <aside className="w-64 shrink-0 border-r bg-white p-4 space-y-1">
      <NavLink to="/eventos" className={link}>
        Eventos
      </NavLink>
      <NavLink to="/calendario" className={link}>
        Calendario
      </NavLink>
      <NavLink to="/inventario/general" className={link}>
        Inventario (General)
      </NavLink>
      <NavLink to="/inventario/area" className={link}>
        Inventario (Área)
      </NavLink>
      <NavLink to="/inventario/recinto" className={link}>
        Inventario (Recinto)
      </NavLink>
      <NavLink to="/recintos" className={link}>
        Recintos
      </NavLink>
      <NavLink to="/ponentes" className={link}>
        Ponentes
      </NavLink>
      <NavLink to="/auditoria" className={link}>
        Auditoría
      </NavLink>
      <NavLink to="/usuarios" className={link}>
        Usuarios
      </NavLink>
      <NavLink to="/funcionarios" className={link}>
        Funcionarios
      </NavLink>
      <NavLink to="/me" className={link}>
        Mi perfil
      </NavLink>
    </aside>
  )
}

function Topbar() {
  const nav = useNavigate()
  const { user } = useAuth()

  return (
    <header className="h-14 border-b bg-white flex items-center justify-between px-4">
      {/* Logo + título como link */}
      <NavLink to="/" className="flex items-center gap-3 hover:opacity-90">
        <img
          src="/idk-logo.svg"
          alt="IDK Logo"
          className="h-8 w-auto"
        />
        <span className="font-semibold">
          IDK FCA Auditorios
        </span>
      </NavLink>

      <div className="flex items-center gap-3">
        <span className="text-sm text-gray-600">
          {user?.nombre} {user?.apellidoPaterno}
        </span>
        <Button
          variant="outline"
          onClick={() => {
            logout()
            nav('/login')
          }}
        >
          Salir
        </Button>
      </div>
    </header>
  )
}


export default function Layout() {
  return (
    <div className="min-h-screen flex flex-col">
      <Topbar />
      {/* Contenedor principal: Sidebar a la izquierda, contenido a la derecha */}
      <div className="flex flex-1 overflow-hidden">
        <Sidebar />
        <main className="flex-1 p-4 overflow-auto bg-neutral-50">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
