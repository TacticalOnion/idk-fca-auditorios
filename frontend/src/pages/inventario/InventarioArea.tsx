import { useQuery } from '@tanstack/react-query'
import { useMemo, useState } from 'react'
import { api } from '../../lib/api'
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  Table,
  THead,
  TR,
  TH,
  TBody,
  TD,
  Input,
  // shadcn ui
  Button,
  Popover,
  PopoverTrigger,
  PopoverContent,
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@ui/index'
import { Check, ChevronsUpDown } from 'lucide-react'

type Row = { area: string; equipamiento: string; cantidad: number; activo: boolean }

export default function InventarioArea() {
  const { data } = useQuery({
    queryKey: ['inv-area'],
    queryFn: async () => (await api.get<Row[]>('/api/inventario/area')).data,
  })

  // búsqueda por nombre de equipamiento
  const [q, setQ] = useState('')

  // filtro multi-select por área
  const [selectedAreas, setSelectedAreas] = useState<string[]>([])

  // listado de áreas únicas para el combobox
  const areas = useMemo(
    () => Array.from(new Set((data || []).map((r) => r.area))).sort(),
    [data]
  )

  // filas filtradas por búsqueda + áreas seleccionadas
  const rows = useMemo(
    () =>
      (data || []).filter((r) => {
        const matchNombre = r.equipamiento.toLowerCase().includes(q.toLowerCase())
        const matchArea =
          selectedAreas.length === 0 || selectedAreas.includes(r.area)
        return matchNombre && matchArea
      }),
    [data, q, selectedAreas]
  )

  return (
    <Card>
      <CardHeader className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <CardTitle>Inventario por área</CardTitle>

        <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
          {/* búsqueda por nombre de equipamiento */}
          <Input
            placeholder="Buscar equipamiento..."
            value={q}
            onChange={(e) => setQ(e.target.value)}
            className="w-full sm:w-56"
          />

          {/* filtro multi-select por área con Combobox */}
          <MultiCombobox
            label="Filtrar por área"
            items={areas}
            value={selectedAreas}
            onChange={setSelectedAreas}
            placeholder="Todas las áreas"
          />
        </div>
      </CardHeader>

      <CardContent className="overflow-auto">
        <Table>
          <THead>
            <TR>
              <TH>Área</TH>
              <TH>Equipamiento</TH>
              <TH>Cantidad</TH>
              <TH>Activo</TH>
            </TR>
          </THead>
          <TBody>
            {rows.map((r, i) => (
              <TR key={i}>
                <TD>{r.area}</TD>
                <TD>{r.equipamiento}</TD>
                <TD>{r.cantidad}</TD>
                <TD>{String(r.activo)}</TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}

type MultiComboboxProps = {
  items: string[]
  value: string[]
  onChange: (value: string[]) => void
  placeholder?: string
  label?: string
}

function MultiCombobox({
  items,
  value,
  onChange,
  placeholder = 'Seleccionar...',
  label,
}: MultiComboboxProps) {
  const [open, setOpen] = useState(false)

  const selectedCount = value.length

  const displayValue =
    selectedCount === 0
      ? placeholder
      : selectedCount === 1
      ? value[0]
      : `${selectedCount} seleccionadas`

  const toggleItem = (item: string) => {
    if (value.includes(item)) {
      onChange(value.filter((v) => v !== item))
    } else {
      onChange([...value, item])
    }
  }

  return (
    <div className="flex flex-col text-sm">
      {label && <span className="mb-1 font-medium">{label}</span>}

      <Popover open={open} onOpenChange={setOpen}>
        <PopoverTrigger asChild>
          <Button
            variant="outline"
            role="combobox"
            aria-expanded={open}
            className="w-48 justify-between"
          >
            <span className="truncate">{displayValue}</span>
            <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
          </Button>
        </PopoverTrigger>
        <PopoverContent className="w-56 p-0">
          <Command>
            <CommandInput placeholder="Buscar..." />
            <CommandEmpty>No se encontraron resultados.</CommandEmpty>
            <CommandList>
              <CommandGroup>
                {items.map((item) => {
                  const isSelected = value.includes(item)
                  return (
                    <CommandItem
                      key={item}
                      value={item}
                      onSelect={() => toggleItem(item)}
                    >
                      <Check
                        className={`mr-2 h-4 w-4 ${
                          isSelected ? 'opacity-100' : 'opacity-0'
                        }`}
                      />
                      {item}
                    </CommandItem>
                  )
                })}
              </CommandGroup>
            </CommandList>
          </Command>
        </PopoverContent>
      </Popover>

      <span className="mt-1 text-xs text-muted-foreground">
        {selectedCount === 0
          ? 'Sin filtro aplicado.'
          : 'Haz clic de nuevo sobre un elemento para quitarlo.'}
      </span>
    </div>
  )
}
