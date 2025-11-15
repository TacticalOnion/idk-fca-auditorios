import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { api } from '@/lib/api'
import {
  Button,
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  Input,
  Table,
  THead,
  TR,
  TH,
  TBody,
  TD,
  // Sheet
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetFooter,
  // Popover + Command para Combobox shadcn
  Popover,
  PopoverTrigger,
  PopoverContent,
  Command,
  CommandInput,
  CommandEmpty,
  CommandGroup,
  CommandItem,
} from '@ui/index'
import { useState } from 'react'
import { toast } from 'sonner'
import type { Calendario } from '@/types/index'
import axios from 'axios'
import { ChevronsUpDown, Check } from 'lucide-react'
import { cn } from '@/lib/utils'

type TipoPeriodoOption = {
  id: number
  nombre: string
}

type PeriodoForm = {
  idTipoPeriodo?: number
  fechaInicio: string
  fechaFin: string
}

// Combobox de shadcn para elegir tipo de periodo
function TipoPeriodoCombobox(props: {
  options: TipoPeriodoOption[]
  value?: number
  onChange: (value: number | undefined) => void
  placeholder?: string
}) {
  const { options, value, onChange, placeholder = 'Selecciona un tipo' } = props
  const [open, setOpen] = useState(false)

  const selected = options.find((o) => o.id === value)

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          type="button"
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className="w-full justify-between"
        >
          {selected ? selected.nombre : <span className="text-muted-foreground">{placeholder}</span>}
          <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-60 p-0">
        <Command>
          <CommandInput placeholder="Buscar tipo de periodo..." />
          <CommandEmpty>Sin resultados.</CommandEmpty>
          <CommandGroup>
            {options.map((opt) => (
              <CommandItem
                key={opt.id}
                value={opt.nombre}
                onSelect={() => {
                  const newValue = opt.id
                  onChange(newValue)
                  setOpen(false)
                }}
              >
                <Check
                  className={cn(
                    'mr-2 h-4 w-4',
                    opt.id === value ? 'opacity-100' : 'opacity-0',
                  )}
                />
                {opt.nombre}
              </CommandItem>
            ))}
          </CommandGroup>
        </Command>
      </PopoverContent>
    </Popover>
  )
}

export default function CalendarioPage() {
  const qc = useQueryClient()

  // Calendarios con periodos
  const { data } = useQuery({
    queryKey: ['calendario'],
    queryFn: async () => (await api.get<Calendario[]>('/api/calendario')).data,
  })

  // Tipos de periodo para el Combobox
  const { data: tiposPeriodo } = useQuery({
    queryKey: ['calendario', 'tipos-periodo'],
    queryFn: async () =>
      (await api.get<TipoPeriodoOption[]>('/api/calendario/tipos-periodo')).data,
  })

  const [open, setOpen] = useState(false)
  const [semestre, setSemestre] = useState('')
  const [semInicio, setSemInicio] = useState('')
  const [semFin, setSemFin] = useState('')
  const [periodos, setPeriodos] = useState<PeriodoForm[]>([])

  const create = useMutation({
    mutationFn: async () => {
      await api.post('/api/calendario', {
        semestre,
        semestreInicio: semInicio,
        semestreFin: semFin,
        periodos: periodos.map((p) => ({
          idTipoPeriodo: p.idTipoPeriodo,
          fechaInicio: p.fechaInicio,
          fechaFin: p.fechaFin,
        })),
      })
    },
    onSuccess: () => {
      toast.success('Calendario creado')
      setOpen(false)
      setSemestre('')
      setSemInicio('')
      setSemFin('')
      setPeriodos([])
      qc.invalidateQueries({ queryKey: ['calendario'] })
    },
    onError: (err: unknown) => {
      const msg = axios.isAxiosError(err)
        ? (err.response?.data as { message?: string })?.message ?? 'Error'
        : 'Error'
      toast.error(msg)
    },
  })

  const periodosValidos =
    periodos.length > 0 &&
    periodos.every(
      (p) => p.idTipoPeriodo && p.fechaInicio && p.fechaFin,
    )

  const canSave =
    !!semestre &&
    !!semInicio &&
    !!semFin &&
    periodosValidos &&
    !create.isPending

  const handleAddPeriodo = () => {
    setPeriodos((prev) => [
      ...prev,
      { idTipoPeriodo: undefined, fechaInicio: '', fechaFin: '' },
    ])
  }

  const handleRemovePeriodo = (idx: number) => {
    setPeriodos((prev) => prev.filter((_, i) => i !== idx))
  }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Calendario escolar</CardTitle>
        <Button onClick={() => setOpen(true)}>Nuevo</Button>
      </CardHeader>

      <CardContent>
        <Table>
          <THead>
            <TR>
              <TH>Semestre</TH>
              <TH>Periodo</TH>
              <TH>Fecha inicio</TH>
              <TH>Fecha fin</TH>
            </TR>
          </THead>
          <TBody>
            {data?.flatMap((c) =>
              c.periodos && c.periodos.length > 0
                ? c.periodos.map((p) => (
                    <TR key={`${c.id}-${p.id}`}>
                      <TD>{c.semestre}</TD>
                      <TD>{p.tipoPeriodo}</TD>
                      <TD>{p.fechaInicio}</TD>
                      <TD>{p.fechaFin}</TD>
                    </TR>
                  ))
                : [
                    <TR key={c.id}>
                      <TD>{c.semestre}</TD>
                      <TD colSpan={3} className="text-muted-foreground italic">
                        Sin periodos registrados
                      </TD>
                    </TR>,
                  ],
            )}
          </TBody>
        </Table>
      </CardContent>

      {/* Sheet para nuevo calendario */}
      <Sheet open={open} onOpenChange={setOpen}>
        <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
          <SheetHeader>
            <SheetTitle className='rounded-md bg-primary text-white text-center text-2xl p-3'>Nuevo calendario</SheetTitle>
          </SheetHeader>

          <div className="mt-4 p-1 space-y-4">
            {/* Datos del semestre */}
            <div className="space-y-2">
              <div>
                <label className="text-sm">Semestre</label>
                <Input
                  value={semestre}
                  onChange={(e) => setSemestre(e.target.value)}
                  placeholder="2025-1"
                />
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                <div>
                  <label className="text-sm">Semestre inicio</label>
                  <Input
                    type="date"
                    value={semInicio}
                    onChange={(e) => setSemInicio(e.target.value)}
                  />
                </div>
                <div>
                  <label className="text-sm">Semestre fin</label>
                  <Input
                    type="date"
                    value={semFin}
                    onChange={(e) => setSemFin(e.target.value)}
                  />
                </div>
              </div>
            </div>

            {/* Periodos */}
            <div className="space-y-2">
              <div className="font-medium">Periodos</div>
              <p className="text-xs text-muted-foreground">
                Debe capturar al menos un periodo. El sistema validará que haya
                al menos un periodo de cada tipo configurado.
              </p>

              {periodos.map((p, idx) => (
                <div
                  key={idx}
                  className="grid grid-cols-1 sm:grid-cols-[minmax(0,1.2fr)_minmax(0,1.6fr)_auto] gap-2 items-center border rounded-md p-2"
                >
                  {/* Tipo periodo combobox */}
                  <div>
                    <span className="text-xs text-muted-foreground">
                      Tipo periodo
                    </span>
                    <TipoPeriodoCombobox
                      options={tiposPeriodo ?? []}
                      value={p.idTipoPeriodo}
                      onChange={(value) =>
                        setPeriodos((prev) =>
                          prev.map((x, i) =>
                            i === idx ? { ...x, idTipoPeriodo: value } : x,
                          ),
                        )
                      }
                      placeholder="Selecciona tipo"
                    />
                  </div>

                  {/* Fechas del periodo */}
                  <div className="grid grid-cols-2 gap-2">
                    <div>
                      <span className="text-xs text-muted-foreground">
                        Periodo inicio
                      </span>
                      <Input
                        type="date"
                        value={p.fechaInicio}
                        onChange={(e) =>
                          setPeriodos((prev) =>
                            prev.map((x, i) =>
                              i === idx
                                ? { ...x, fechaInicio: e.target.value }
                                : x,
                            ),
                          )
                        }
                      />
                    </div>
                    <div>
                      <span className="text-xs text-muted-foreground">
                        Periodo fin
                      </span>
                      <Input
                        type="date"
                        value={p.fechaFin}
                        onChange={(e) =>
                          setPeriodos((prev) =>
                            prev.map((x, i) =>
                              i === idx
                                ? { ...x, fechaFin: e.target.value }
                                : x,
                            ),
                          )
                        }
                      />
                    </div>
                  </div>

                  {/* Botón quitar */}
                  <div className="flex justify-end">
                    <Button
                      type="button"
                      variant="destructive"
                      size="icon"
                      onClick={() => handleRemovePeriodo(idx)}
                    >
                      X
                    </Button>
                  </div>
                </div>
              ))}

              <Button
                type="button"
                variant="outline"
                onClick={handleAddPeriodo}
              >
                Agregar periodo
              </Button>
            </div>
          </div>

          <SheetFooter className="mt-4">
            <Button
              type="button"
              onClick={() => create.mutate()}
              disabled={!canSave}
            >
              {create.isPending ? 'Guardando...' : 'Guardar'}
            </Button>
          </SheetFooter>
        </SheetContent>
      </Sheet>
    </Card>
  )
}
