import { NavLink, Outlet, useNavigate } from 'react-router-dom'
import { Button } from '@ui/index'
import { useAuth } from '@/lib/useAuth'
import { logout } from '@/lib/logout'
import { getUserRoles, type RoleKey } from '@/lib/getUserRoles'

type NavItem = {
  label: string
  to: string
  roles: RoleKey[]
}

function Sidebar() {
  const { user } = useAuth()
  const roles = getUserRoles(user)

  const link = ({ isActive }: { isActive: boolean }) =>
    `block px-3 py-2 rounded-md ${
      isActive ? 'bg-primary text-white' : 'text-gray-700 hover:bg-gray-100'
    }`

  const canSee = (allowed: RoleKey[]) => {
    if (allowed.length === 0) return true
    // Si no pudimos detectar roles, mostramos todo (fallback amigable)
    if (roles.length === 0) return true
    return allowed.some((r) => roles.includes(r))
  }

  const items: NavItem[] = [
    {
      label: 'Eventos',
      to: '/eventos',
      roles: ['ADMINISTRADOR', 'SUPERADMINISTRADOR'],
    },
    {
      label: 'Mis eventos',
      to: '/mis-eventos',
      roles: ['FUNCIONARIO'],
    },
    {
      label: 'Calendario escolar',
      to: '/calendario',
      roles: ['SUPERADMINISTRADOR'],
    },
    {
      label: 'Inventario (General)',
      to: '/inventario/general',
      roles: ['ADMINISTRADOR'],
    },
    {
      label: 'Inventario (Área)',
      to: '/inventario/area',
      roles: ['ADMINISTRADOR'],
    },
    {
      label: 'Inventario (Recinto)',
      to: '/inventario/recinto',
      roles: ['ADMINISTRADOR'],
    },
    {
      label: 'Recintos',
      to: '/recintos',
      roles: ['ADMINISTRADOR'],
    },
    {
      label: 'Ponentes',
      to: '/ponentes',
      roles: ['ADMINISTRADOR'],
    },
    {
      label: 'Auditoría',
      to: '/auditoria',
      roles: ['SUPERADMINISTRADOR'],
    },
    {
      label: 'Usuarios',
      to: '/usuarios',
      roles: ['SUPERADMINISTRADOR'],
    },
    {
      label: 'Funcionarios',
      to: '/funcionarios',
      roles: ['ADMINISTRADOR'],
    },
    {
      label: 'Mi perfil',
      to: '/me',
      roles: ['SUPERADMINISTRADOR', 'ADMINISTRADOR', 'FUNCIONARIO'],
    },
  ]

  return (
    <aside className="w-64 shrink-0 border-r bg-white p-4 space-y-1">
      {items
        .filter((item) => canSee(item.roles))
        .map((item) => (
          <NavLink key={item.to} to={item.to} className={link}>
            {item.label}
          </NavLink>
        ))}
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
        <img src="/idk-logo.svg" alt="IDK Logo" className="h-8 w-auto" />
        <span className="font-semibold">FCA Auditorios</span>
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
      <div className="flex flex-1 overflow-hidden">
        <Sidebar />
        <main className="flex-1 p-4 overflow-auto bg-neutral-50">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
