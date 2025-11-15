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

export default function RecintoCreateSheet({
  onClose,
  onSaved
}: {
  onClose: () => void
  onSaved: () => void
}) {
  const [nombre, setNombre] = useState('')
  const [aforo, setAforo] = useState('')
  const [latitud, setLatitud] = useState('')
  const [longitud, setLongitud] = useState('')
  const [idTipoRecinto, setIdTipoRecinto] = useState('')
  const [croquisFile, setCroquisFile] = useState<File | null>(null)
  const [fotos, setFotos] = useState<File[]>([])
  const [saving, setSaving] = useState(false)

  const { data: tipos } = useQuery({
    queryKey: ['tipoRecinto'],
    queryFn: async () => (await api.get<TipoRecinto[]>('/api/recintos/tipos')).data
  })

  function handleCroquisChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0] ?? null
    setCroquisFile(file)
  }

  function handleFotosChange(e: React.ChangeEvent<HTMLInputElement>) {
    const list = e.target.files
    setFotos(list ? Array.from(list) : [])
  }

  async function save() {
    if (!nombre.trim()) {
      toast.error('El nombre es obligatorio')
      return
    }
    if (!aforo || Number(aforo) <= 0) {
      toast.error('El aforo debe ser mayor a 0')
      return
    }
    if (!latitud || !longitud) {
      toast.error('Latitud y longitud son obligatorias')
      return
    }
    if (!idTipoRecinto) {
      toast.error('Selecciona un tipo de recinto')
      return
    }
    if (!croquisFile) {
      toast.error('Debes subir un croquis')
      return
    }
    if (fotos.length < 4) {
      toast.error('Debes subir al menos 4 fotografías')
      return
    }

    try {
      setSaving(true)
      const form = new FormData()
      form.append('nombre', nombre)
      form.append('aforo', aforo)
      form.append('latitud', latitud)
      form.append('longitud', longitud)
      form.append('idTipoRecinto', idTipoRecinto)
      form.append('croquis', croquisFile)
      fotos.forEach(f => form.append('fotografias', f))

      await api.post('/api/recintos', form, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })

      toast.success('Recinto creado')
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

  return (
    <Sheet
      open
      onOpenChange={isOpen => {
        if (!isOpen) onClose()
      }}
    >
      <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
        <SheetHeader>
          <SheetTitle className='rounded-md bg-primary text-white text-center text-2xl p-3'>Agregar recinto</SheetTitle>
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
            <label className="text-sm font-medium">Croquis</label>
            <input
              type="file"
              accept="image/*,.pdf"
              onChange={handleCroquisChange}
              className="mt-1 block w-full text-sm"
            />
          </div>

          <div>
            <label className="text-sm font-medium">Fotografías (mínimo 4)</label>
            <input
              type="file"
              accept="image/*"
              multiple
              onChange={handleFotosChange}
              className="mt-1 block w-full text-sm"
            />
            <div className="text-xs text-gray-500 mt-1">
              Seleccionadas: {fotos.length}
            </div>
          </div>

          <div className="flex justify-end gap-2 pt-4">
            <Button variant="ghost" onClick={onClose}>
              Cancelar
            </Button>
            <Button onClick={save} disabled={saving}>
              {saving ? 'Guardando...' : 'Guardar'}
            </Button>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  )
}
