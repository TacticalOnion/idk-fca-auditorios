import { useState } from "react"
import {
  Popover,
  PopoverTrigger,
  PopoverContent,
} from "@ui/popover"
import { Button, Input, Label } from "@ui/index"

type Props = {
  onConfirm: (motivo: string) => void
  disabled?: boolean
  children: React.ReactNode // normalmente será el botón "Cancelar"
}

export function CancelEventPopover({ onConfirm, disabled, children }: Props) {
  const [open, setOpen] = useState(false)
  const [motivo, setMotivo] = useState("")

  const confirm = () => {
    if (!motivo.trim()) return
    onConfirm(motivo.trim())
    setMotivo("")
    setOpen(false)
  }

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild disabled={disabled}>
        {children}
      </PopoverTrigger>

      <PopoverContent className="w-80 p-4 space-y-3">
        <div className="space-y-2">
          <Label>Motivo de cancelación</Label>
          <Input
            placeholder="Escribe el motivo..."
            value={motivo}
            onChange={(e) => setMotivo(e.target.value)}
          />
        </div>

        <div className="flex justify-end gap-2 pt-2">
          <Button
            variant="outline"
            size="sm"
            onClick={() => {
              setMotivo("")
              setOpen(false)
            }}
          >
            Cerrar
          </Button>

          <Button
            size="sm"
            disabled={!motivo.trim()}
            onClick={confirm}
          >
            Confirmar
          </Button>
        </div>
      </PopoverContent>
    </Popover>
  )
}
