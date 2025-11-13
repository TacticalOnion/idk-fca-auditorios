import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  Table,
  TBody,
  TD,
  TH,
  THead,
  TR,
  Button,
  Separator,
  Badge,
  Textarea
} from '@ui/index'
import { Download } from 'lucide-react'
import { toast } from 'sonner'
import type {
  DetalleEvento,
  Evento,
  PonenteEvento,
  OrganizadorEvento,
  AreaEvento,
  EquipamientoEvento,
} from '@/types'

function Pill({ kind, children }: { kind: 'success' | 'danger'; children: React.ReactNode }) {
  const cls =
    kind === 'success'
      ? 'inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800'
      : 'inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800'
  return <span className={cls}>{children}</span>
}

// 🔹 Helper: nombre completo de ponente, robusto a distintos shapes
function getPonenteNombreCompleto(p: PonenteEvento): string {
  const v = p as unknown as {
    nombreCompleto?: string | null
    nombre?: string | null
    apellidoPaterno?: string | null
    apellidoMaterno?: string | null
  }

  if (v.nombreCompleto) return v.nombreCompleto

  const parts = [v.nombre, v.apellidoPaterno, v.apellidoMaterno].filter(Boolean)
  return parts.length ? parts.join(' ') : '-'
}

// 🔹 Helper: nombre completo de organizador, igual idea
function getOrganizadorNombreCompleto(o: OrganizadorEvento): string {
  const v = o as unknown as {
    nombreCompleto?: string | null
    nombre?: string | null
    apellidoPaterno?: string | null
    apellidoMaterno?: string | null
  }

  if (v.nombreCompleto) return v.nombreCompleto

  const parts = [v.nombre, v.apellidoPaterno, v.apellidoMaterno].filter(Boolean)
  return parts.length ? parts.join(' ') : '-'
}

export default function EventDetailSheet({
  id,
  open,
  onOpenChange,
}: {
  id: number
  open: boolean
  onOpenChange: (open: boolean) => void
}) {
  const { data } = useQuery({
    queryKey: ['evento-detalle', id],
    queryFn: async () =>
      (await api.get<DetalleEvento>(`/api/eventos/${id}/detalle`)).data,
  })

  const ev: Evento | undefined = data?.evento
  const ponentes: PonenteEvento[] = data?.ponentes ?? []
  const organizadores: OrganizadorEvento[] = data?.organizadores ?? []
  const areas: AreaEvento[] = data?.areas ?? []
  const equipamiento: EquipamientoEvento[] = data?.equipamiento ?? []

  const recinto = ev?.recinto ?? '-'

  // --- helpers descarga de PDF de ponente (semblanza y reconocimiento) ---

  function buildFileSafeName(nombre: string): string {
    return nombre
      .normalize('NFD')
      .replace(/\p{Diacritic}/gu, '')
      .replace(/[^a-zA-Z0-9]+/g, '_')
      .replace(/^_+|_+$/g, '')
      .toLowerCase()
  }

  async function descargarSemblanzaPonente(p: PonenteEvento) {
    try {
      if (!p.id) {
        toast.error('No se pudo identificar al ponente')
        return
      }

      const res = await api.post(
        `/api/ponentes/${p.id}/descargar-semblanza`,
        null,
        { responseType: 'blob' },
      )

      const blob = res.data as Blob
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a')

      const nombre = getPonenteNombreCompleto(p) || 'semblanza'
      const safe = buildFileSafeName(nombre)

      a.href = url
      a.download = `semblanza_${safe}.pdf`
      a.click()

      URL.revokeObjectURL(url)
    } catch (err) {
      console.error(err)
      toast.error('No se pudo descargar la semblanza')
    }
  }

  async function descargarReconocimientoPonente(p: PonenteEvento) {
    try {
      if (!p.id) {
        toast.error('No se pudo identificar al ponente')
        return
      }

      const res = await api.post(
        `/api/eventos/${id}/ponentes/${p.id}/descargar-reconocimiento`,
        null,
        { responseType: 'blob' },
      )

      const blob = res.data as Blob
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a')

      const nombre = getPonenteNombreCompleto(p) || 'reconocimiento'
      const safe = buildFileSafeName(nombre)

      a.href = url
      a.download = `reconocimiento_${safe}.pdf`
      a.click()

      URL.revokeObjectURL(url)
    } catch (err) {
      console.error(err)
      toast.error('No se pudo descargar el reconocimiento')
    }
  }

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent className="w-full sm:max-w-4xl p-6">
        <SheetHeader>
          <SheetTitle><div className='rounded-md bg-primary text-white text-center text-2xl p-3'>{ev?.nombre ?? 'Evento'}</div></SheetTitle>
        </SheetHeader>

        {/* scroll interno propio */}
        <div className="space-y-6 mt-4 max-h-[80vh] overflow-y-auto pr-2">

          {/* SOBRE EL EVENTO */}
          <section>
          <div className="font-semibold mb-2">Sobre el evento</div>
          <Separator className="my-4" />

          <div className="text-sm space-y-4">
            {/* Badges */}
            <div className="flex flex-wrap gap-2">
              <Badge variant="outline">
                {ev?.categoria ?? '-'}
              </Badge>

              <Badge variant="outline">
                {ev?.presencial ? 'Presencial' : ''}
              </Badge>

              <Badge variant="outline">
                {ev?.online ? 'Online' : ''}
              </Badge>

              <Badge variant="outline">
                {ev?.estatus ?? '-'}
              </Badge>

              <Badge variant="outline">
                {ev?.nombreMegaEvento ?? ''}
              </Badge>

              {ev?.isMegaEvento && (
                <Badge variant="secondary">
                  Tipo: Mega evento
                </Badge>
              )}
            </div>

            {/* Descripción */}
            <div>
              <div className="font-medium mb-1">Descripción</div>
              <div className="text-muted-foreground">
                {ev?.descripcion ?? '-'}
              </div>
            </div>

            {/* Fechas / Horario / Calendario escolar */}
            <div className="grid gap-4 md:grid-cols-3">
              <div>
                <div className="font-medium mb-1">Fechas</div>
                <div>
                  [{ev?.fechaInicio ?? '-'}] - [{ev?.fechaFin ?? '-'}]
                </div>
              </div>

              <div>
                <div className="font-medium mb-1">Horario</div>
                <div>
                  {ev?.horarioInicio ?? ''} - {ev?.horarioFin ?? ''}
                </div>
              </div>

              <div>
                <div className="font-medium mb-1">Calendario escolar</div>
                <div>{ev?.calendarioEscolar ?? '-'}</div>
              </div>
            </div>

            {/* Recinto / Número / Fecha de registro */}
            <div className="grid gap-4 md:grid-cols-3">
              <div>
                <div className="font-medium mb-1">Recinto</div>
                <div>{recinto}</div>
              </div>

              <div>
                <div className="font-medium mb-1">Número de registro</div>
                <div>{ev?.numeroRegistro ?? '-'}</div>
              </div>

              <div>
                <div className="font-medium mb-1">Fecha de registro</div>
                <div>{ev?.fechaRegistro ?? '-'}</div>
              </div>
            </div>            

            {/* Motivo como Textarea deshabilitado */}
            <div>
              <div className="font-medium mb-1">Motivo</div>
              <Textarea
                disabled
                value={ev?.motivo ?? 'No ha sido cancelado el evento'}
                placeholder="-"
                className="min-h-20 resize-none"
              />
            </div>
          </div>
        </section>
          

          {/* PONENTES */}
          <section>
            <div className="font-semibold mb-2">Ponentes</div>
            <Separator className="my-4" />

            {ponentes.length === 0 ? (
              <div className="text-sm text-gray-600">
                Sin ponentes registrados.
              </div>
            ) : (
              <Table>
                <THead>
                  <TR>
                    <TH>Nombre completo</TH>
                    <TH className="text-center">Acciones</TH>
                  </TR>
                </THead>
                <TBody>
                  {ponentes.map((p, i) => (
                    <TR key={i}>
                      <TD>{getPonenteNombreCompleto(p)}</TD>
                      <TD>
                        <div className="flex gap-2 justify-center">
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => descargarSemblanzaPonente(p)}
                            title="Descargar semblanza"
                          >
                            <Download className="w-4 h-4 mr-1" />
                            Semblanza
                          </Button>

                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => descargarReconocimientoPonente(p)}
                            title="Descargar reconocimiento"
                          >
                            <Download className="w-4 h-4 mr-1" />
                            Reconocimiento
                          </Button>
                        </div>
                      </TD>
                    </TR>
                  ))}
                </TBody>
              </Table>
            )}
          </section>

          {/* ORGANIZADORES */}
          <section>
            <div className="font-semibold mb-2">Organizadores</div>
            <Separator className="my-4" />

            {organizadores.length === 0 ? (
              <div className="text-sm text-gray-600">
                Sin organizadores registrados.
              </div>
            ) : (
              <div className="text-sm">
                {organizadores
                  .map((o) => getOrganizadorNombreCompleto(o))
                  .join(', ')}
              </div>
            )}
          </section>

          {/* ÁREAS */}
          <section>
            <div className="font-semibold mb-2">Áreas involucradas</div>
            <Separator className="my-4" />

            <div className="text-sm">
              {areas.length
                ? areas.map((a) => a.area).join(', ')
                : 'Sin áreas registradas.'}
            </div>
          </section>

          {/* EQUIPAMIENTO */}
          <section>
            <div className="font-semibold mb-2">Equipamiento solicitado</div>
            <Separator className="my-4" />
            
            {equipamiento.length === 0 ? (
              <div className="text-sm text-gray-600">
                Sin equipamiento registrado.
              </div>
            ) : (
              <Table>
                <THead>
                  <TR>
                    <TH>Equipamiento</TH>
                    <TH>Cantidad</TH>
                    <TH>Disponible</TH>
                    <TH>Faltante</TH>
                  </TR>
                </THead>
                <TBody>
                  {equipamiento.map((e, i) => (
                    <TR key={i}>
                      <TD>{e.equipamiento}</TD>
                      <TD>{e.cantidad ?? '-'}</TD>
                      <TD>{e.disponible ? 'Sí' : 'No'}</TD>
                      <TD>
                        {e.cantidadFaltante && e.cantidadFaltante > 0 ? (
                          <Pill kind="danger">{e.cantidadFaltante}</Pill>
                        ) : (
                          <Pill kind="success">0</Pill>
                        )}
                      </TD>
                    </TR>
                  ))}
                </TBody>
              </Table>
            )}
          </section>
        </div>
      </SheetContent>
    </Sheet>
  )
}
