import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
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
import { Download, Plus, ClipboardCheck } from 'lucide-react'
import KanbanView from './KanbanView'
import CalendarView from './CalendarView'
import CreateEventSheet from '@/components/CreateEventSheet'
import EventDetailSheet from './EventDetailSheet'
import type {
  Evento,
  PonenteEvento,
  OrganizadorEvento,
  AreaEvento,
  EquipamientoEvento,
} from '../../types'
import axios from 'axios'

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
  const qc = useQueryClient()
  const { data } = useQuery({
    queryKey: ['eventos'],
    queryFn: async () => (await api.get<Evento[]>('/api/eventos')).data,
  })
  const [q, setQ] = useState('')
  const [estatus, setEstatus] = useState<string>('')
  const [openDetail, setOpenDetail] = useState(false)
  const [selId, setSelId] = useState<number | null>(null)
  const [openCreate, setOpenCreate] = useState(false)

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

  const verificar = useMutation({
    mutationFn: async (id: number) =>
      (
        await api.get<
          Array<{ faltante: number; nombre_equipamiento: string }>
        >(`/api/eventos/${id}/verificar-equipamiento`)
      ).data,
    onSuccess: (rows) => {
      if (!rows?.length) {
        toast.success('Sin requerimientos registrados')
        return
      }
      const faltantes = rows.filter((r) => Number(r.faltante) > 0)
      if (faltantes.length === 0) toast.success('Equipamiento suficiente')
      else
        toast.warning(
          'Equipamiento insuficiente: ' +
            faltantes.map((x) => x.nombre_equipamiento).join(', '),
        )
    },
    onError: (err: unknown) =>
      toast.error(
        axios.isAxiosError(err)
          ? (err.response?.data as { message?: string })?.message ??
              'Error al verificar'
          : 'Error al verificar',
      ),
  })

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

  function toCsvValue(v: unknown): string {
    const s = v == null ? '' : String(v)
    const escaped = s.replace(/"/g, '""')
    return `"${escaped}"`
  }

  function downloadSelectedCsv() {
    const selectedEvents = (data || []).filter((e) =>
      selectedIds.includes(e.id),
    )
    if (!selectedEvents.length) {
      toast.error('No hay eventos seleccionados')
      return
    }

    const header = [
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

    const lines: string[] = []
    lines.push(header.map(toCsvValue).join(','))

    selectedEvents.forEach((e) => {
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

      const equipamiento = normalizeJsonArray<EquipamientoEvento>(
        e.equipamiento,
      )
        .map((eq) => `${eq.cantidad} x ${eq.equipamiento}`)
        .join(' | ')

      const row = [
        e.nombre,
        e.categoria ?? '',
        e.nombreMegaEvento ?? '',
        e.isMegaEvento ?? '',
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

      lines.push(row.map(toCsvValue).join(','))
    })

    const csv = lines.join('\n')
    const blob = new Blob([csv], {
      type: 'text/csv;charset=utf-8;',
    })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = 'eventos_seleccionados.csv'
    a.click()
    URL.revokeObjectURL(url)
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

          {/* botón CSV activable solo con selección */}
          <Button
            variant="outline"
            disabled={selectedIds.length === 0}
            onClick={downloadSelectedCsv}
          >
            <Download size={16} className="mr-2" />
            Exportar CSV
          </Button>

          <Button onClick={() => setOpenCreate(true)}>
            <Plus size={16} className="mr-2" /> Nuevo
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
                  <TH>Tipo</TH>
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
                  <TH className="text-center">Verificar equipamiento</TH>
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
                      <TD>{e.nombre}</TD>
                      <TD>{e.categoria ?? '-'}</TD>
                      <TD>{e.nombreMegaEvento ?? '-'}</TD>
                      <TD>{e.isMegaEvento ?? ''}</TD>
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

                      {/* Verificar equipamiento */}
                      <TD className="text-center">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => verificar.mutate(e.id)}
                          title="Verificar equipamiento"
                        >
                          <ClipboardCheck size={18} />
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

      {/* Alta */}
      {openCreate && (
        <CreateEventSheet
          onClose={() => setOpenCreate(false)}
          onCreated={() => {
            setOpenCreate(false)
            qc.invalidateQueries({ queryKey: ['eventos'] })
          }}
        />
      )}
    </Card>
  )
}
