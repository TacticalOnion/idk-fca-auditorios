import { Navigate, Route, Routes } from 'react-router-dom'
import { useAuth } from '@/lib/useAuth'
import AuthProvider from '@/lib/AuthProvider'
import LoginPage from './pages/auth/Login'
import Layout from './pages/_layout/Layout'
import MePage from './pages/profile/Me'
import AuditoriaPage from './pages/auditoria/AuditoriaPage'
import CalendarioPage from './pages/calendario/CalendarioPage'
import EventosPage from './pages/eventos/EventosPage'
import InventarioGeneral from './pages/inventario/InventarioGeneral'
import InventarioArea from './pages/inventario/InventarioArea'
import InventarioRecinto from './pages/inventario/InventarioRecinto'
import RecintosGallery from './pages/recintos/RecintosGallery'
import PonentesPage from './pages/ponentes/PonentesPage'
import UsuariosPage from './pages/usuarios/UsuariosPage'
import FuncionariosPage from './pages/funcionarios/FuncionariosPage'
import MisEventosPage from '@/pages/mis-eventos/MisEventosPage'

function Private({ children }: { children: React.ReactNode }) {
  const { isAuthenticated } = useAuth()
  if (!isAuthenticated) return <Navigate to="/login" replace />
  return <>{children}</>
}

export default function App() {
  return (
    <AuthProvider>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route
          path="/"
          element={<Private><Layout /></Private>}
        >
          <Route index element={<Navigate to="/eventos" replace/>} />
          <Route path="me" element={<MePage/>} />
          <Route path="auditoria" element={<AuditoriaPage/>} />
          <Route path="calendario" element={<CalendarioPage/>} />
          <Route path="eventos" element={<EventosPage/>} />
          <Route path="inventario/general" element={<InventarioGeneral/>} />
          <Route path="inventario/area" element={<InventarioArea/>} />
          <Route path="inventario/recinto" element={<InventarioRecinto/>} />
          <Route path="recintos" element={<RecintosGallery/>} />
          <Route path="ponentes" element={<PonentesPage/>} />
          <Route path="usuarios" element={<UsuariosPage/>} />
          <Route path="funcionarios" element={<FuncionariosPage/>} />
          <Route path="mis-eventos" element={<MisEventosPage/>} />
        </Route>
      </Routes>
    </AuthProvider>
  )
}
