import { createContext } from 'react'

export type User = {
  nombreUsuario: string
  nombre?: string
  apellidoPaterno?: string
  apellidoMaterno?: string
  correo?: string
  telefono?: string
  celular?: string
  rfc?: string
  activo?: boolean
  rol?: string
}

export type AuthCtx = {
  isAuthenticated: boolean
  user: User | null
  login: (username: string, password: string) => Promise<void>
  refreshMe: () => Promise<void>
}

export const AuthContext = createContext<AuthCtx | undefined>(undefined)
