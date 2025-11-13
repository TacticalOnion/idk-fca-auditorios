import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import {
  Button,
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
} from '@ui/index'
import type {
  DetalleEvento,
  Organizador,
  RecintoDet,
  EquipamientoDet,
  AreaDet,
} from '../../types'

function Pill({ kind, children }: { kind: 'success' | 'danger'; children: React.ReactNode }) {
  const cls =
    kind === 'success'
      ? 'inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800'
      : 'inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800'
  return <span className={cls}>{children}</span>
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

  const ev = data?.evento as Record<string, unknown> | undefined
  const organizadores = (data?.organizadores || []) as Organizador[]
  const recintos = (data?.recintos || []) as RecintoDet[]
  const eq = (data?.equipamiento || []) as EquipamientoDet[]
  const areas = (data?.areas || []) as AreaDet[]

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent>
        <SheetHeader>
          <SheetTitle>{(ev?.nombre as string) || 'Evento'}</SheetTitle>
        </SheetHeader>
        <div className="space-y-6 mt-2">
          <section>
            <div className="font-semibold mb-2">Resumen</div>
            <div className="text-sm grid grid-cols-2 gap-2">
              <div>
                <b>Estatus:</b> {ev?.estatus as string}
              </div>
              <div>
                <b>Registro:</b>{' '}
                {(ev?.numeroRegistro as string) || '-'}
              </div>
              <div className="col-span-2">
                <b>Descripción:</b>{' '}
                {(ev?.descripcion as string) || '-'}
              </div>
              <div className="col-span-2">
                <b>Fechas:</b> {ev?.fechaInicio as string}{' '}
                {ev?.horarioInicio as string} — {ev?.fechaFin as string}{' '}
                {ev?.horarioFin as string}
              </div>
              <div>
                <b>Modalidad:</b>{' '}
                {(ev?.presencial ? 'Presencial ' : '')}
                {ev?.online ? 'Online' : ''}
              </div>
              <div>
                <b>Categoría:</b> {String(ev?.idCategoria ?? '')}
              </div>
            </div>
          </section>

          <section>
            <div className="font-semibold mb-2">Organizadores</div>
            <Table>
              <THead>
                <TR>
                  <TH>Usuario</TH>
                  <TH>Nombre</TH>
                  <TH>Correo</TH>
                </TR>
              </THead>
              <TBody>
                {organizadores.map((o) => (
                  <TR key={o.id}>
                    <TD>{o.username}</TD>
                    <TD>
                      {o.nombre} {o.apellidoPaterno}{' '}
                      {o.apellidoMaterno}
                    </TD>
                    <TD>{o.correo}</TD>
                  </TR>
                ))}
              </TBody>
            </Table>
          </section>

          <section>
            <div className="font-semibold mb-2">
              Recintos reservados
            </div>
            <Table>
              <THead>
                <TR>
                  <TH>Recinto</TH>
                  <TH>Aforo</TH>
                  <TH>Croquis</TH>
                </TR>
              </THead>
              <TBody>
                {recintos.map((r) => (
                  <TR key={r.id}>
                    <TD>{r.nombre}</TD>
                    <TD>{r.aforo ?? '-'}</TD>
                    <TD>
                      {r.croquis ? (
                        <a
                          className="underline text-blue-600"
                          href={`${import.meta.env.VITE_API_URL}/files${r.croquis}`}
                          target="_blank"
                          rel="noreferrer"
                        >
                          Ver
                        </a>
                      ) : (
                        '-'
                      )}
                    </TD>
                  </TR>
                ))}
              </TBody>
            </Table>
          </section>

          <section>
            <div className="font-semibold mb-2">
              Equipamiento solicitado
            </div>
            <Table>
              <THead>
                <TR>
                  <TH>Equipo</TH>
                  <TH>Solicitado</TH>
                  <TH>Disponible</TH>
                  <TH>Faltante</TH>
                </TR>
              </THead>
              <TBody>
                {eq.map((x) => (
                  <TR key={x.id}>
                    <TD>{x.nombre}</TD>
                    <TD>{x.solicitado}</TD>
                    <TD>{x.disponible}</TD>
                    <TD>
                      {x.faltante ? (
                        <Pill kind="danger">{x.faltante}</Pill>
                      ) : (
                        <Pill kind="success">0</Pill>
                      )}
                    </TD>
                  </TR>
                ))}
              </TBody>
            </Table>
          </section>

          <section>
            <div className="font-semibold mb-2">
              Áreas involucradas
            </div>
            <div className="text-sm text-gray-600">
              {areas.length
                ? areas.map((a) => a.nombre).join(', ')
                : 'Sin áreas inferidas por los organizadores.'}
            </div>
          </section>

          <div className="flex justify-end">
            <Button
              variant="ghost"
              onClick={() => onOpenChange(false)}
            >
              Cerrar
            </Button>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  )
}
