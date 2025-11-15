import { useState } from 'react'
import { Button, Input, Sheet, SheetContent, SheetHeader, SheetTitle } from '@ui/index'
import { api } from '../../lib/api'
import { useQuery } from '@tanstack/react-query'
import { toast } from 'sonner'
import axios from 'axios'

type TipoRecinto = {
  id: number
  nombre: string
}

export type Recinto = {
  id: number
  nombre: string
  aforo: number
  latitud: number
  longitud: number
  idTipoRecinto: number
  croquis: string
  activo?: boolean
}

export default function RecintoEditSheet({
  recinto,
  onClose,
  onSaved
}: {
  recinto: Recinto
  onClose: () => void
  onSaved: () => void
}) {
  const [nombre, setNombre] = useState(recinto?.nombre ?? '')
  const [aforo, setAforo] = useState(recinto?.aforo != null ? String(recinto.aforo) : '')
  const [latitud, setLatitud] = useState(recinto?.latitud != null ? String(recinto.latitud) : '')
  const [longitud, setLongitud] = useState(
    recinto?.longitud != null ? String(recinto.longitud) : ''
  )
  const [idTipoRecinto, setIdTipoRecinto] = useState(
    recinto?.idTipoRecinto != null ? String(recinto.idTipoRecinto) : ''
  )
  const [saving, setSaving] = useState(false)
  const [deleting, setDeleting] = useState(false)

  const { data: tipos } = useQuery({
    queryKey: ['tipoRecinto'],
    queryFn: async () => (await api.get<TipoRecinto[]>('/api/recintos/tipos')).data
  })

  async function save() {
    try {
      setSaving(true)
      await api.patch(`/api/recintos/${recinto.id}`, {
        nombre,
        aforo: aforo ? Number(aforo) : null,
        latitud: latitud ? Number(latitud) : null,
        longitud: longitud ? Number(longitud) : null,
        idTipoRecinto: idTipoRecinto ? Number(idTipoRecinto) : null
      })
      toast.success('Recinto actualizado')
      onSaved()
    } catch (err: unknown) {
      const msg = axios.isAxiosError(err)
        ? (err.response?.data as { message?: string })?.message ?? 'Error al guardar'
        : 'Error al guardar'
      toast.error(msg)
    } finally {
      setSaving(false)
    }
  }

  async function remove() {
    if (!confirm('¿Eliminar (baja lógica) este recinto?')) return
    try {
      setDeleting(true)
      await api.delete(`/api/recintos/${recinto.id}`)
      toast.success('Recinto eliminado')
      onSaved()
    } catch (err: unknown) {
      const msg = axios.isAxiosError(err)
        ? (err.response?.data as { message?: string })?.message ?? 'Error al eliminar'
        : 'Error al eliminar'
      toast.error(msg)
    } finally {
      setDeleting(false)
    }
  }

  return (
    <Sheet
      open
      onOpenChange={isOpen => {
        if (!isOpen) onClose()
      }}
    >
      <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
        <SheetHeader>
          <SheetTitle className='rounded-md bg-primary text-white text-center text-2xl p-3' >Editar recinto</SheetTitle>
        </SheetHeader>

        <div className="space-y-3 mt-2">
          <div>
            <label className="text-sm font-medium">Nombre</label>
            <Input value={nombre} onChange={e => setNombre(e.target.value)} />
          </div>

          <div>
            <label className="text-sm font-medium">Aforo</label>
            <Input
              type="number"
              min={1}
              value={aforo}
              onChange={e => setAforo(e.target.value)}
            />
          </div>

          <div className="grid grid-cols-2 gap-2">
            <div>
              <label className="text-sm font-medium">Latitud</label>
              <Input
                type="number"
                step="0.000001"
                value={latitud}
                onChange={e => setLatitud(e.target.value)}
              />
            </div>
            <div>
              <label className="text-sm font-medium">Longitud</label>
              <Input
                type="number"
                step="0.000001"
                value={longitud}
                onChange={e => setLongitud(e.target.value)}
              />
            </div>
          </div>

          <div>
            <label className="text-sm font-medium">Tipo de recinto</label>
            <select
              className="mt-1 block w-full border rounded-md px-2 py-2 text-sm"
              value={idTipoRecinto}
              onChange={e => setIdTipoRecinto(e.target.value)}
            >
              <option value="">Seleccione una opción</option>
              {tipos?.map(t => (
                <option key={t.id} value={t.id}>
                  {t.nombre}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="text-sm font-medium">Croquis (solo lectura)</label>
            <Input value={recinto.croquis ?? ''} readOnly />
          </div>

          <div className="flex justify-between pt-4">
            <Button variant="destructive" onClick={remove} disabled={deleting}>
              {deleting ? 'Eliminando...' : 'Eliminar'}
            </Button>
            <div className="flex gap-2">
              <Button onClick={save} disabled={saving}>
                {saving ? 'Guardando...' : 'Guardar'}
              </Button>
            </div>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  )
}
