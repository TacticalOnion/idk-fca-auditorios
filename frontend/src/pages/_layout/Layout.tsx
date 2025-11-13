import { NavLink, Outlet, useNavigate } from 'react-router-dom'
import { Button } from '@ui/index'
import { useAuth } from '@/lib/useAuth'
import { logout } from '@/lib/logout'

type RoleKey = 'SUPERADMINISTRADOR' | 'ADMINISTRADOR' | 'FUNCIONARIO'

type NavItem = {
  label: string
  to: string
  roles: RoleKey[]
}

function getUserRoles(user: unknown): RoleKey[] {
  if (!user || typeof user !== 'object') return []

  const u = user as Record<string, unknown>
  const names = new Set<string>()

  const collectFromArray = (value: unknown) => {
    if (Array.isArray(value)) {
      for (const v of value) {
        if (typeof v === 'string') {
          names.add(v)
        } else if (v && typeof v === 'object') {
          const obj = v as Record<string, unknown>
          const maybeName =
            (typeof obj.authority === 'string' && obj.authority) ||
            (typeof obj.nombre === 'string' && obj.nombre) ||
            (typeof obj.name === 'string' && obj.name)
          if (maybeName) {
            names.add(maybeName)
          }
        }
      }
    }
  }

  // posibles formas en que vengan los roles
  collectFromArray(u.roles)
  collectFromArray(u.authorities)

  const simpleKeys = ['rol', 'role', 'rolUsuario']
  for (const key of simpleKeys) {
    const v = u[key]
    if (!v) continue

    if (typeof v === 'string') {
      names.add(v)
    } else if (typeof v === 'object') {
      const obj = v as Record<string, unknown>
      if (typeof obj.nombre === 'string') {
        names.add(obj.nombre)
      } else if (typeof obj.name === 'string') {
        names.add(obj.name)
      }
    }
  }

  const result: RoleKey[] = []
  for (const raw of names) {
    const upper = raw.toUpperCase()
    const clean = upper.startsWith('ROLE_') ? upper.slice(5) : upper

    if (
      clean === 'SUPERADMINISTRADOR' ||
      clean === 'ADMINISTRADOR' ||
      clean === 'FUNCIONARIO'
    ) {
      if (!result.includes(clean as RoleKey)) {
        result.push(clean as RoleKey)
      }
    }
  }

  return result
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
    // Dashboard eventos (ADMINISTRADOR) – la vista actual de eventos
    {
      label: 'Eventos',
      to: '/eventos',
      roles: ['ADMINISTRADOR', 'SUPERADMINISTRADOR'],
    },
    // Dashboard mis eventos (FUNCIONARIO) – misma ruta o futura ruta separada
    {
      label: 'Mis eventos',
      to: '/mis-eventos', // pendiente de implementar
      roles: ['FUNCIONARIO'],
    },
    // Calendario escolar (SUPERADMINISTRADOR)
    {
      label: 'Calendario escolar',
      to: '/calendario',
      roles: ['SUPERADMINISTRADOR'],
    },
    // Dashboard inventario (ADMINISTRADOR) – dividimos en las 3 vistas actuales
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
    // Dashboard recintos (ADMINISTRADOR)
    {
      label: 'Recintos',
      to: '/recintos',
      roles: ['ADMINISTRADOR'],
    },
    // Registros ponentes (ADMINISTRADOR)
    {
      label: 'Ponentes',
      to: '/ponentes',
      roles: ['ADMINISTRADOR'],
    },
    // Registro auditoría (SUPERADMINISTRADOR)
    {
      label: 'Auditoría',
      to: '/auditoria',
      roles: ['SUPERADMINISTRADOR'],
    },
    // Dashboard usuarios (SUPERADMINISTRADOR)
    {
      label: 'Usuarios',
      to: '/usuarios',
      roles: ['SUPERADMINISTRADOR'],
    },
    // Dashboard funcionarios (ADMINISTRADOR)
    {
      label: 'Funcionarios',
      to: '/funcionarios',
      roles: ['ADMINISTRADOR'],
    },
    // Mi perfil (todos)
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
