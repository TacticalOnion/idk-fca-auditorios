import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Button, Card, CardContent, CardHeader, CardTitle} from '@ui/index'
import { useRef, useState } from 'react'
import { toast } from 'sonner'
import RecintoEditSheet, { type Recinto } from './RecintoEditSheet'
import axios from 'axios'

type RecintoCard = {
  id: number
  nombre: string
  capacidad?: number | null
  portada?: string | null
  fotos?: Array<{ ruta:string }>
}

export default function RecintosGallery(){
  const { data } = useQuery({ queryKey:['recintos'], queryFn: async ()=> (await api.get<RecintoCard[]>('/api/recintos')).data })
  const qc = useQueryClient()
  const fileRef = useRef<HTMLInputElement>(null)
  const idRef = useRef<HTMLInputElement>(null)
  const [sel,setSel] = useState<RecintoCard|null>(null)

  const subir = useMutation({
    mutationFn: async ()=>{
      const id = Number(idRef.current?.value)
      const files = fileRef.current?.files
      if (!id || !files || files.length===0) throw new Error('ID y archivos requeridos')
      const form = new FormData()
      Array.from(files).forEach(f=>form.append('files', f))
      form.append('portadaIndex','0')
      await api.post(`/api/recintos/${id}/fotos`, form, { headers:{'Content-Type':'multipart/form-data'} })
    },
    onSuccess: ()=>{ toast.success('Fotos subidas'); qc.invalidateQueries({queryKey:['recintos']}) },
    onError: (err: unknown)=> {
      const msg = axios.isAxiosError(err) ? (err.response?.data as { message?: string })?.message ?? 'Error al subir fotos' : 'Error al subir fotos'
      toast.error(msg)
    }
  })

  function refresh(){ qc.invalidateQueries({queryKey:['recintos']}); setSel(null) }

  // Mapea el card (galería) al shape que espera el sheet de edición
  function toRecinto(r: RecintoCard): Recinto {
    return {
      id: r.id,
      nombre: r.nombre,
      capacidad: r.capacidad ?? null,
      // usamos portada como croquis por compatibilidad visual (si tienes croquis real, cámbialo aquí)
      croquis: r.portada ?? '',
      activo: true,     // asumimos activo por defecto; si tu API lo expone, pásalo aquí
      // ubicacion es opcional en el sheet; la dejamos vacía
      ubicacion: ''
    }
  }

  return (
    <div className="space-y-4">
      <Card>
        <CardHeader><CardTitle>Subir fotografías</CardTitle></CardHeader>
        <CardContent className="flex gap-2 items-center">
          {/* usamos input nativo para evitar ref casting */}
          <input className="border rounded px-2 py-2 text-sm" placeholder="ID recinto" ref={idRef} type="number" />
          <input type="file" ref={fileRef} multiple />
          <Button onClick={()=>subir.mutate()}>Subir</Button>
        </CardContent>
      </Card>

      <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {data?.map((r)=>(
          <Card key={r.id}>
            <img src={`${import.meta.env.VITE_API_URL}/files${r.portada}`} alt="" className="w-full h-40 object-cover rounded-t-lg"/>
            <CardContent>
              <div className="font-semibold">{r.nombre}</div>
              <div className="text-sm text-gray-600">Capacidad: {r.capacidad ?? '-'}</div>
              <div className="text-xs mt-2">Fotos: {r.fotos?.length || 0}</div>
              <div className="pt-2"><Button variant="outline" onClick={()=>setSel(r)}>Editar</Button></div>
            </CardContent>
          </Card>
        ))}
      </div>

      {sel && <RecintoEditSheet recinto={toRecinto(sel)} onClose={()=>setSel(null)} onSaved={refresh}/>}
    </div>
  )
}