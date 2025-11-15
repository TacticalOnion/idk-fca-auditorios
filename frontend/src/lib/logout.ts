// src/lib/logout.ts
import { clearAuthStorage } from './auth-storage'

/**
 * Limpia toda la información de autenticación (token + usuario)
 * y deja la sesión cerrada.
 */
export function logout() {
  clearAuthStorage()
}
