import { useQuery } from '@tanstack/react-query'
import { useMemo, useState } from 'react'
import { api } from '../../lib/api'
import {
  Button,
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  Input,
  Table,
  TBody,
  TD,
  TH,
  THead,
  TR,
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetDescription,
} from '@ui/index'
import { Download } from 'lucide-react'
import { toast } from 'sonner'

type Row = {
  id: number
  nombre: string
  // Soportamos tanto snake_case como camelCase según lo que regrese el backend
  apellido_paterno?: string
  apellido_materno?: string
  apellidoPaterno?: string
  apellidoMaterno?: string
  id_pais?: number
  idPais?: number
  semblanzaArchivo?: string | null
}

type ReconRow = {
  idEvento: number
  nombreEvento: string
  reconocimiento?: string | null
}

function getNombreCompleto(p: Row): string {
  const apP = p.apellido_paterno ?? p.apellidoPaterno ?? ''
  const apM = p.apellido_materno ?? p.apellidoMaterno ?? ''
  return [p.nombre, apP, apM].join(' ').replace(/\s+/g, ' ').trim()
}

export default function PonentesPage() {
  const { data, refetch } = useQuery({
    queryKey: ['ponentes'],
    queryFn: async () => (await api.get<Row[]>('/api/ponentes')).data,
  })

  // Búsqueda por nombre del ponente (nombre completo)
  const [q, setQ] = useState('')

  const rows = useMemo(
    () =>
      (data || []).filter((p) =>
        getNombreCompleto(p).toLowerCase().includes(q.toLowerCase())
      ),
    [data, q]
  )

  // Descargar semblanza (PDF) de un ponente
  async function descargarSemblanza(id: number) {
    try {
      const res = await api.post<Blob>(
        `/api/ponentes/${id}/descargar-semblanza`,
        null,
        { responseType: 'blob' }
      )

      const disposition = res.headers['content-disposition'] as
        | string
        | undefined
      let fileName = `semblanza_${id}.pdf`
      if (disposition) {
        const match = disposition.match(/filename="?([^"]+)"?/i)
        if (match?.[1]) fileName = match[1]
      }

      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a')
      a.href = url
      a.download = fileName
      a.click()
      URL.revokeObjectURL(url)
    } catch (e) {
      console.error(e)
      toast.error('Error al descargar la semblanza')
    } finally {
      // por si el backend actualiza algo (ruta en DB, etc.)
      refetch()
    }
  }

  // ===== Sheet de reconocimientos =====
  const [sheetOpen, setSheetOpen] = useState(false)
  const [ponenteActivo, setPonenteActivo] = useState<Row | null>(null)
  const [reconocimientos, setReconocimientos] = useState<ReconRow[]>([])
  const [loadingReconocimientos, setLoadingReconocimientos] = useState(false)

  async function abrirReconocimientos(ponente: Row) {
    setPonenteActivo(ponente)
    setSheetOpen(true)
    setLoadingReconocimientos(true)
    try {
      const res = await api.get<ReconRow[]>(
        `/api/ponentes/${ponente.id}/reconocimientos`
      )
      setReconocimientos(res.data || [])
    } catch (e) {
      console.error(e)
      toast.error('Error al cargar reconocimientos')
      setReconocimientos([])
    } finally {
      setLoadingReconocimientos(false)
    }
  }

  // Descargar reconocimiento (PDF) para un evento concreto
  async function descargarReconocimiento(idPonente: number, idEvento: number) {
    try {
      const res = await api.post<Blob>(
        `/api/eventos/${idEvento}/ponentes/${idPonente}/descargar-reconocimiento`,
        null,
        { responseType: 'blob' }
      )

      const disposition = res.headers['content-disposition'] as
        | string
        | undefined
      let fileName = `reconocimiento_evento_${idEvento}_ponente_${idPonente}.pdf`
      if (disposition) {
        const match = disposition.match(/filename="?([^"]+)"?/i)
        if (match?.[1]) fileName = match[1]
      }

      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a')
      a.href = url
      a.download = fileName
      a.click()
      URL.revokeObjectURL(url)
    } catch (e) {
      console.error(e)
      toast.error('Error al descargar el reconocimiento')
    }
  }

  return (
    <>
      <Card>
        <CardHeader className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
          <CardTitle>Ponentes</CardTitle>
          <div className="flex w-full flex-col gap-2 sm:w-auto sm:flex-row sm:items-center">
            <Input
              placeholder="Buscar ponente..."
              value={q}
              onChange={(e) => setQ(e.target.value)}
              className="w-full sm:w-72"
            />
          </div>
        </CardHeader>
        <CardContent className="overflow-auto">
          <Table>
            <THead>
              <TR>
                <TH>Ponente</TH>
                <TH className="w-32 text-center">Semblanza</TH>
                <TH className="w-40 text-center">Reconocimientos</TH>
              </TR>
            </THead>
            <TBody>
              {rows.map((p) => (
                <TR key={p.id}>
                  <TD>{getNombreCompleto(p)}</TD>
                  <TD className="text-center">
                    <Button
                      variant="outline"
                      size="icon"
                      onClick={() => descargarSemblanza(p.id)}
                      title="Descargar semblanza"
                    >
                      <Download className="h-4 w-4" />
                    </Button>
                  </TD>
                  <TD className="text-center">
                    <Button
                      variant="outline"
                      onClick={() => abrirReconocimientos(p)}
                    >
                      <Download className="mr-2 h-4 w-4" />
                      Reconocimientos
                    </Button>
                  </TD>
                </TR>
              ))}
            </TBody>
          </Table>
        </CardContent>
      </Card>

      {/* Sheet de reconocimientos por ponente */}
      <Sheet
        open={sheetOpen}
        onOpenChange={(open) => {
          setSheetOpen(open)
          if (!open) {
            setPonenteActivo(null)
            setReconocimientos([])
          }
        }}
      >
        <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
          <SheetHeader>
            <SheetTitle className='rounded-md bg-primary text-white text-center text-2xl p-3'>
              Reconocimientos
              {ponenteActivo ? ` - ${getNombreCompleto(ponenteActivo)}` : ''}
            </SheetTitle>
            <SheetDescription>
              Selecciona un evento para descargar el reconocimiento.
            </SheetDescription>
          </SheetHeader>

          <div className="mt-4 flex-1 overflow-auto">
            {loadingReconocimientos ? (
              <p className="text-sm text-muted-foreground">Cargando...</p>
            ) : reconocimientos.length === 0 ? (
              <p className="text-sm text-muted-foreground">
                No hay reconocimientos registrados para este ponente.
              </p>
            ) : (
              <Table>
                <THead>
                  <TR>
                    <TH>Evento</TH>
                    <TH className="w-32 text-center">Descargar</TH>
                  </TR>
                </THead>
                <TBody>
                  {reconocimientos.map((r) => (
                    <TR key={r.idEvento}>
                      <TD>{r.nombreEvento}</TD>
                      <TD className="text-center">
                        <Button
                          variant="outline"
                          size="icon"
                          onClick={() =>
                            ponenteActivo &&
                            descargarReconocimiento(ponenteActivo.id, r.idEvento)
                          }
                          title="Descargar reconocimiento"
                        >
                          <Download className="h-4 w-4" />
                        </Button>
                      </TD>
                    </TR>
                  ))}
                </TBody>
              </Table>
            )}
          </div>
        </SheetContent>
      </Sheet>
    </>
  )
}
