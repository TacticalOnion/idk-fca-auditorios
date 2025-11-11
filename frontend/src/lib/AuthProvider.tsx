import React, { useEffect, useState } from 'react'
import { api } from './api'
import { setToken, setUser as setUserStorage, getToken as storageGetToken } from './auth-storage'
import { AuthContext } from './auth-context'
import type { User } from './auth-context'

export default function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null)
  const isAuthenticated = Boolean(storageGetToken())

  useEffect(() => {
    if (isAuthenticated) { void refreshMe() }
  }, [isAuthenticated])

  async function login(username: string, password: string) {
    // JSON con los nombres que espera el backend
    const body = {
      username,
      password,
    }

    const { data } = await api.post('/api/auth/login', body) // application/json por defecto

    setToken(data.access_token) // "Bearer " se agrega en api.ts
    await refreshMe()
  }

  async function refreshMe() {
    const { data } = await api.get<User>('/api/usuarios/me')
    setUser(data)
    setUserStorage(data)
  }

  return (
    <AuthContext.Provider value={{ isAuthenticated, user, login, refreshMe }}>
      {children}
    </AuthContext.Provider>
  )
}
