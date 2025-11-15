export type RoleKey = 'SUPERADMINISTRADOR' | 'ADMINISTRADOR' | 'FUNCIONARIO'

export function getUserRoles(user: unknown): RoleKey[] {
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
