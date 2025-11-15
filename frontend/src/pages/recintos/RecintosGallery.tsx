import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { api } from '../../lib/api'
import {
  Button,
  Card,
  CardContent,
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle
} from '@ui/index'
import { useRef, useState } from 'react'
import { toast } from 'sonner'
import RecintoEditSheet, { type Recinto as RecintoEdit } from './RecintoEditSheet'
import RecintoCreateSheet from './RecintoCreateSheet'
import axios from 'axios'

type Fotografia = {
  id: number
  fotografia: string // ruta relativa en backend (ej: /recinto/fotografias/xxx.png)
}

type RecintoCard = {
  id: number
  nombre: string
  aforo: number
  latitud: number
  longitud: number
  croquis: string // ej: /recinto/croquis/xxx.png
  tipoRecinto: string
  idTipoRecinto: number
  fotografias: Fotografia[]
}

// Base del backend, viene de Vite (.env)
const API_BASE = import.meta.env.VITE_API_URL ?? ''

/**
 * Construye la URL pública de una imagen.
 * - En BD viene algo como: /recinto/fotografias/xxx.png o /recinto/croquis/xxx.png
 * - El backend expone directamente /recinto/** (WebConfig)
 * - Resultado final: {API_BASE}/recinto/fotografias/xxx.png
 */
function buildImgUrl(path?: string | null): string {
  if (!path) return ''

  // Si ya es una URL absoluta (por si acaso)
  if (/^https?:\/\//.test(path)) {
    return path
  }

  // Aseguramos que empiece con "/"
  const normalized = path.startsWith('/') ? path : `/${path}`

  // El backend ya sirve /recinto/**, no necesitamos /files
  return `${API_BASE}${normalized}`
}

export default function RecintosGallery() {
  const { data } = useQuery({
    queryKey: ['recintos'],
    queryFn: async () => (await api.get<RecintoCard[]>('/api/recintos')).data
  })

  const qc = useQueryClient()

  const [sel, setSel] = useState<RecintoCard | null>(null)
  const [fotoRecinto, setFotoRecinto] = useState<RecintoCard | null>(null)
  const [crearOpen, setCrearOpen] = useState(false)

  const fileRef = useRef<HTMLInputElement>(null)
  const [recintoParaFotos, setRecintoParaFotos] = useState<RecintoCard | null>(null)

  const subirFotos = useMutation({
    mutationFn: async (params: { id: number; files: FileList }) => {
      const form = new FormData()
      Array.from(params.files).forEach(f => form.append('files', f))
      form.append('portadaIndex', '0')

      await api.post(`/api/recintos/${params.id}/fotos`, form, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
    },
    onSuccess: () => {
      toast.success('Fotos subidas')
      qc.invalidateQueries({ queryKey: ['recintos'] })
    },
    onError: (err: unknown) => {
      const msg = axios.isAxiosError(err)
        ? (err.response?.data as { message?: string })?.message ?? 'Error al subir fotos'
        : 'Error al subir fotos'
      toast.error(msg)
    }
  })

  function refresh() {
    qc.invalidateQueries({ queryKey: ['recintos'] })
    setSel(null)
    setCrearOpen(false)
  }

  function toRecintoEdit(r: RecintoCard): RecintoEdit {
    return {
      id: r.id,
      nombre: r.nombre,
      aforo: r.aforo,
      latitud: r.latitud,
      longitud: r.longitud,
      idTipoRecinto: r.idTipoRecinto,
      croquis: r.croquis,
      activo: true
    }
  }

  function handleClickAgregarFotos(recinto: RecintoCard) {
    setRecintoParaFotos(recinto)
    fileRef.current?.click()
  }

  function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const files = e.target.files
    if (!files || files.length === 0 || !recintoParaFotos) return
    subirFotos.mutate({ id: recintoParaFotos.id, files })
    e.target.value = ''
  }

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl font-semibold">Recintos</h2>
        <Button onClick={() => setCrearOpen(true)}>Agregar recinto</Button>
      </div>

      <input
        type="file"
        multiple
        ref={fileRef}
        className="hidden"
        accept="image/*"
        onChange={handleFileChange}
      />

      <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {data?.map(r => {
          const portada = r.fotografias?.[0]?.fotografia ?? null
          const mapaLink =
            r.latitud != null && r.longitud != null
              ? `https://www.google.com/maps?q=${r.latitud},${r.longitud}`
              : null

          return (
            <Card key={r.id} className="flex flex-col">
              {portada ? (
                <img
                  src={buildImgUrl(portada)}
                  alt={r.nombre}
                  className="w-full h-40 object-cover rounded-t-lg"
                />
              ) : (
                <div className="w-full h-40 bg-gray-200 rounded-t-lg flex items-center justify-center text-xs text-gray-500">
                  Sin fotografía
                </div>
              )}

              <CardContent className="flex-1 flex flex-col gap-2 pt-3">
                <div>
                  <div className="font-semibold">{r.nombre}</div>
                  <div className="text-sm text-gray-600">{r.tipoRecinto}</div>
                  <div className="text-sm text-gray-600">Aforo: {r.aforo ?? '-'}</div>
                  {mapaLink && (
                    <a
                      href={mapaLink}
                      target="_blank"
                      rel="noreferrer"
                      className="text-xs text-blue-600 underline"
                    >
                      Ver en Google Maps
                    </a>
                  )}
                </div>

                <div className="text-xs text-gray-500">
                  Fotografías: {r.fotografias?.length ?? 0}
                </div>

                <div className="flex flex-wrap gap-2 mt-2">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => setFotoRecinto(r)}
                    disabled={!r.fotografias || r.fotografias.length === 0}
                  >
                    Ver fotos
                  </Button>
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => handleClickAgregarFotos(r)}
                  >
                    Agregar fotografías
                  </Button>
                  <Button variant="outline" size="sm" onClick={() => setSel(r)}>
                    Editar
                  </Button>
                </div>
              </CardContent>
            </Card>
          )
        })}
      </div>

      {sel && (
        <RecintoEditSheet
          recinto={toRecintoEdit(sel)}
          onClose={() => setSel(null)}
          onSaved={refresh}
        />
      )}

      {crearOpen && (
        <RecintoCreateSheet onClose={() => setCrearOpen(false)} onSaved={refresh} />
      )}

      {fotoRecinto && (
        <Sheet
          open
          onOpenChange={isOpen => {
            if (!isOpen) setFotoRecinto(null)
          }}
        >
          <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
            <SheetHeader>
              <SheetTitle className='rounded-md bg-primary text-white text-center text-2xl p-3'>Fotografías - {fotoRecinto.nombre}</SheetTitle>
            </SheetHeader>

            <div className="space-y-2">
              <div className="text-sm font-medium">Croquis</div>
              {fotoRecinto.croquis ? (
                <img
                  src={buildImgUrl(fotoRecinto.croquis)}
                  alt={`Croquis de ${fotoRecinto.nombre}`}
                  className="w-full max-h-64 object-contain border rounded-md"
                />
              ) : (
                <div className="text-xs text-gray-500">Sin croquis registrado</div>
              )}
            </div>

            <div className="space-y-2">
              <div className="text-sm font-medium">Fotografías</div>
              {fotoRecinto.fotografias?.length ? (
                <div className="grid grid-cols-2 gap-2 max-h-[400px] overflow-auto pr-2">
                  {fotoRecinto.fotografias.map(f => (
                    <img
                      key={f.id}
                      src={buildImgUrl(f.fotografia)}
                      alt="foto"
                      className="w-full h-32 object-cover rounded-md"
                    />
                  ))}
                </div>
              ) : (
                <div className="text-xs text-gray-500">Sin fotografías</div>
              )}
            </div>
          </SheetContent>
        </Sheet>
      )}
    </div>
  )
}
