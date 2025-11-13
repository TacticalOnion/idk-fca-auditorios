import { useQuery} from '@tanstack/react-query'
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
  Tabs,
  TabsList,
  TabsTrigger,
  TabsContent,
} from '@ui/index'
import { useMemo, useState } from 'react'
import { toast } from 'sonner'
import { Download} from 'lucide-react'
import KanbanView from './KanbanView'
import CalendarView from './CalendarView'
import EventDetailSheet from './EventDetailSheet'
import type {
  Evento,
  PonenteEvento,
  OrganizadorEvento,
  AreaEvento,
  EquipamientoEvento,
} from '../../types'
import * as XLSX from 'xlsx'
import jsPDF from 'jspdf'
import autoTable from 'jspdf-autotable'

function normalizeJsonArray<T>(value: unknown): T[] {
  if (value == null) return []

  // Ya es un arreglo real
  if (Array.isArray(value)) {
    return value as T[]
  }

  // Caso típico de Postgres jsonb con JdbcTemplate:
  // { type: 'jsonb', value: '[{...}]' }
  if (typeof value === 'object') {
    const v = (value as { value?: unknown }).value

    if (Array.isArray(v)) {
      return v as T[]
    }

    if (typeof v === 'string') {
      try {
        const parsed = JSON.parse(v)
        return Array.isArray(parsed) ? (parsed as T[]) : []
      } catch {
        return []
      }
    }
  }

  // Si viene como string JSON plano
  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value)
      return Array.isArray(parsed) ? (parsed as T[]) : []
    } catch {
      return []
    }
  }

  return []
}

export default function EventosPage() {
  const { data } = useQuery({
    queryKey: ['eventos'],
    queryFn: async () => (await api.get<Evento[]>('/api/eventos')).data,
  })
  const [q, setQ] = useState('')
  const [estatus, setEstatus] = useState<string>('')
  const [openDetail, setOpenDetail] = useState(false)
  const [selId, setSelId] = useState<number | null>(null)

  // selección múltiple para CSV
  const [selectedIds, setSelectedIds] = useState<number[]>([])

  const filtered = useMemo(
    () =>
      (data || [])
        .filter((e) => e.nombre?.toLowerCase().includes(q.toLowerCase()))
        .filter((e) => !estatus || e.estatus === estatus),
    [data, q, estatus],
  )

  function openDetailSheet(ev: Evento) {
    setSelId(ev.id)
    setOpenDetail(true)
  }

  async function descargarZip(id: number) {
    try {
      const res = await api.post(
        `/api/eventos/${id}/descargar-reconocimientos`,
        null,
        { responseType: 'blob' },
      )
      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a')
      a.href = url
      a.download = `reconocimientos_evento_${id}.zip`
      a.click()
      URL.revokeObjectURL(url)
    } catch {
      toast.error('No hay reconocimientos o error de descarga')
    }
  }

  async function descargarSemblanzas(id:number){
    try{
      const res = await api.post(`/api/eventos/${id}/descargar-semblanzas`, null, { responseType:'blob' })
      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a'); a.href = url; a.download = `semblanzas_evento_${id}.zip`; a.click()
      URL.revokeObjectURL(url)
    }catch{
      toast.error('No hay semblanzas o error de descarga')
    }
  }

  // --------- selección / CSV ----------
    // --------- selección / exportaciones ----------

  const allSelected =
    filtered.length > 0 &&
    filtered.every((e) => selectedIds.includes(e.id))

  function toggleSelectAll() {
    if (allSelected) {
      setSelectedIds([])
    } else {
      setSelectedIds(filtered.map((e) => e.id))
    }
  }

  function toggleSelectOne(id: number) {
    setSelectedIds((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id],
    )
  }

  // Encabezados de exportación
  const exportHeader = [
    'nombre',
    'categoria',
    'megaEvento',
    'isMegaEvento',
    'recinto',
    'fechaInicio',
    'fechaFin',
    'horarioInicio',
    'horarioFin',
    'presencial',
    'online',
    'estatus',
    'descripcion',
    'motivo',
    'fechaRegistro',
    'numeroRegistro',
    'calendarioEscolar',
    'ponentes',
    'organizadores',
    'areas',
    'equipamiento',
  ]

  function buildExportRow(e: Evento): string[] {
    const ponentes = normalizeJsonArray<PonenteEvento>(e.ponentes)
      .map((p) => p.nombreCompleto)
      .join(' | ')

    const organizadores = normalizeJsonArray<OrganizadorEvento>(
      e.organizadores,
    )
      .map((o) => o.nombreCompleto)
      .join(' | ')

    const areas = normalizeJsonArray<AreaEvento>(e.areas)
      .map((a) => a.area)
      .join(' | ')

    const equipamiento = normalizeJsonArray<EquipamientoEvento>(e.equipamiento)
      .map((eq) => `${eq.cantidad} x ${eq.equipamiento}`)
      .join(' | ')

    return [
      e.nombre ?? '',
      e.categoria ?? '',
      e.nombreMegaEvento ?? '',
      (e.isMegaEvento ?? '').toString(),
      e.recinto ?? '',
      e.fechaInicio ?? '',
      e.fechaFin ?? '',
      e.horarioInicio ?? '',
      e.horarioFin ?? '',
      e.presencial ? 'Sí' : 'No',
      e.online ? 'Sí' : 'No',
      e.estatus ?? '',
      e.descripcion ?? '',
      e.motivo ?? '',
      e.fechaRegistro ?? '',
      e.numeroRegistro ?? '',
      e.calendarioEscolar ?? '',
      ponentes,
      organizadores,
      areas,
      equipamiento,
    ]
  }

  function getSelectedEvents(): Evento[] | null {
    const selectedEvents = (data || []).filter((e) =>
      selectedIds.includes(e.id),
    )
    if (!selectedEvents.length) {
      toast.error('No hay eventos seleccionados')
      return null
    }
    return selectedEvents
  }

  function downloadSelectedXls() {
    const selectedEvents = getSelectedEvents()
    if (!selectedEvents) return

    const rows = selectedEvents.map(buildExportRow)
    const aoa = [exportHeader, ...rows]

    const worksheet = XLSX.utils.aoa_to_sheet(aoa)
    const workbook = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Eventos')

    XLSX.writeFile(workbook, 'reporte_eventos.xlsx')
  }

  function downloadSelectedPdf() {
    const selectedEvents = getSelectedEvents()
    if (!selectedEvents) return

    const rows = selectedEvents.map(buildExportRow)

    const doc = new jsPDF({ orientation: 'landscape' })

    autoTable(doc, {
      head: [exportHeader],
      body: rows,
      styles: {
        fontSize: 6,
        textColor: [0, 0, 0],      // texto negro
        lineColor: [0, 0, 0],      // líneas negras
        lineWidth: 0.1,
      },
      headStyles: {
        fillColor: false,          // sin fondo
        textColor: [0, 0, 0],
        lineColor: [0, 0, 0],
        lineWidth: 0.1,
        fontStyle: 'bold',
      },
      alternateRowStyles: {
        fillColor: false,          // sin gris alternado
      },
      tableLineColor: [0, 0, 0],    // borde exterior negro
      tableLineWidth: 0.15,
      margin: { top: 10 },
    })

    doc.save('reporte_eventos.pdf')
  }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Eventos</CardTitle>
        <div className="flex gap-2 items-center">
          <Input
            placeholder="Buscar por nombre..."
            value={q}
            onChange={(e) => setQ(e.target.value)}
          />
          <select
            className="border px-2 py-2 rounded-md text-sm"
            value={estatus}
            onChange={(e) => setEstatus(e.target.value)}
          >
            <option value="">Todos</option>
            <option value="pendiente">Pendiente</option>
            <option value="autorizado">Autorizado</option>
            <option value="cancelado">Cancelado</option>
            <option value="realizado">Realizado</option>
          </select>
          {/* botones de exportación activables solo con selección */}
          <Button
            variant="outline"
            disabled={selectedIds.length === 0}
            onClick={downloadSelectedXls}
          >
            <Download size={16} className="mr-2" />
            Exportar XLS
          </Button>

          <Button
            variant="outline"
            disabled={selectedIds.length === 0}
            onClick={downloadSelectedPdf}
          >
            <Download size={16} className="mr-2" />
            Exportar PDF
          </Button>
        </div>
      </CardHeader>

      <CardContent className="overflow-auto">
        <Tabs defaultValue="table">
          <TabsList>
            <TabsTrigger value="table">Tabla</TabsTrigger>
            <TabsTrigger value="kanban">Kanban</TabsTrigger>
            <TabsTrigger value="calendar">Calendario</TabsTrigger>
          </TabsList>

          {/* Tabla */}
          <TabsContent value="table">
            <Table>
              <THead>
                <TR>
                  <TH>
                    <input
                      type="checkbox"
                      checked={allSelected}
                      onChange={toggleSelectAll}
                    />
                  </TH>
                  <TH>Nombre</TH>
                  <TH>Categoría</TH>
                  <TH>Mega evento</TH>
                  <TH>Recinto</TH>
                  <TH>Fecha inicio</TH>
                  <TH>Fecha fin</TH>
                  <TH>Horario inicio</TH>
                  <TH>Horario fin</TH>
                  <TH>Presencial</TH>
                  <TH>Online</TH>
                  <TH>Estatus</TH>
                  <TH>Núm. registro</TH>
                  <TH>Calendario escolar</TH>
                  <TH>Ponentes</TH>
                  <TH>Organizadores</TH>
                  <TH>Áreas</TH>
                  <TH>Equipamiento</TH>
                  <TH className="text-center">Detalles</TH>
                  <TH className="text-center">Reconocimientos</TH>
                  <TH className="text-center">Semblanzas</TH>
                </TR>
              </THead>
              <TBody>
                {filtered.map((e) => {
                  const isSelected = selectedIds.includes(e.id)
                  const ponentes = normalizeJsonArray<PonenteEvento>(e.ponentes)
                  const organizadores = normalizeJsonArray<OrganizadorEvento>(e.organizadores)
                  const areas = normalizeJsonArray<AreaEvento>(e.areas)
                  const equipamiento = normalizeJsonArray<EquipamientoEvento>(e.equipamiento)

                  return (
                    <TR key={e.id} className="align-top">
                      <TD>
                        <input
                          type="checkbox"
                          checked={isSelected}
                          onChange={() => toggleSelectOne(e.id)}
                        />
                      </TD>
                      <TD>{e.nombre} <span className="font-medium">{e.isMegaEvento ?? ''}</span></TD>
                      <TD>{e.categoria ?? '-'}</TD>
                      <TD>{e.nombreMegaEvento ?? '-'}</TD>
                      <TD>{e.recinto ?? '-'}</TD>
                      <TD>{e.fechaInicio ?? '-'}</TD>
                      <TD>{e.fechaFin ?? '-'}</TD>
                      <TD>{e.horarioInicio ?? '-'}</TD>
                      <TD>{e.horarioFin ?? '-'}</TD>
                      <TD>{e.presencial ? 'Sí' : 'No'}</TD>
                      <TD>{e.online ? 'Sí' : 'No'}</TD>
                      <TD>
                        {e.estatus === 'autorizado' && (
                          <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">
                            Autorizado
                          </span>
                        )}
                        {e.estatus === 'pendiente' && (
                          <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-yellow-100 text-yellow-800">
                            Pendiente
                          </span>
                        )}
                        {e.estatus === 'cancelado' && (
                          <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800">
                            Cancelado
                          </span>
                        )}
                        {e.estatus === 'realizado' && (
                          <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-cyan-100 text-cyan-700">
                            Realizado
                          </span>
                        )}
                      </TD>
                      <TD>{e.numeroRegistro ?? '-'}</TD>
                      <TD>{e.calendarioEscolar ?? '-'}</TD>

                      {/* Ponentes */}
                      <TD>
                        {ponentes.length
                          ? ponentes.map((p) => p.nombreCompleto).join(', ')
                          : '-'}
                      </TD>

                      {/* Organizadores */}
                      <TD>
                        {organizadores.length
                          ? organizadores.map((o) => o.nombreCompleto).join(', ')
                          : '-'}
                      </TD>

                      {/* Áreas */}
                      <TD>
                        {areas.length
                          ? areas.map((a) => a.area).join(', ')
                          : '-'}
                      </TD>

                      {/* Equipamiento */}
                      <TD>
                        {equipamiento.length
                          ? equipamiento
                              .map((eq) => `${eq.equipamiento} (${eq.cantidad})`)
                              .join(', ')
                          : '-'}
                      </TD>

                      {/* Detalles */}
                      <TD className="text-center">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => openDetailSheet(e)}
                        >
                          Ver
                        </Button>
                      </TD>

                      {/* Reconocimientos */}
                      <TD className="text-center">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => descargarZip(e.id)}
                          title="Descargar reconocimientos"
                        >
                          <Download size={18} />
                        </Button>
                      </TD>

                      {/* Semblanzas */}
                      <TD className="text-center">
                        <Button
                          variant="ghost"
                          onClick={()=>descargarSemblanzas(e.id)}
                          title="Descargar semblanzas"
                        >
                          <Download size={16}/>
                        </Button>
                      </TD>
                    </TR>
                  )
                })}
              </TBody>
            </Table>
          </TabsContent>

          {/* Kanban */}
          <TabsContent value="kanban">
            <KanbanView data={filtered} />
          </TabsContent>

          {/* Calendario */}
          <TabsContent value="calendar">
            <CalendarView data={filtered} />
          </TabsContent>
        </Tabs>
      </CardContent>

      {/* Detalle como Sheet controlado */}
      {selId !== null && (
        <EventDetailSheet
          id={selId}
          open={openDetail}
          onOpenChange={(isOpen) => {
            setOpenDetail(isOpen)
            if (!isOpen) {
              setSelId(null)
            }
          }}
        />
      )}

    </Card>
  )
}
