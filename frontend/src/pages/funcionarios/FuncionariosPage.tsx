import { useMemo, useState } from 'react'
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
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetDescription,
  SheetTrigger,
  Label,
  Select,
  SelectTrigger,
  SelectContent,
  SelectItem,
  SelectValue,
  Dialog,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
  DialogContent,
  Popover,
  PopoverTrigger,
  PopoverContent,
} from '@ui/index'
import { toast } from 'sonner'
import axios from 'axios'
import { Loader2, Plus, SquarePen } from 'lucide-react'

type CatalogoRol = {
  id: number
  nombre: string
}

type CatalogoPuesto = {
  id: number
  nombre: string
  idArea: number
  areaNombre: string
}

type CatalogosResponse = {
  roles: CatalogoRol[]
  puestos: CatalogoPuesto[]
}

type UsuarioRol =
  | {
      nombre: string
    }
  | string
  | null

type UsuarioArea =
  | {
      id: number
      nombre: string
    }
  | string
  | null

type UsuarioPuesto =
  | {
      id?: number
      nombre?: string
      area?: {
        id: number
        nombre: string
      } | null
    }
  | string
  | null

type Usuario = {
  id: number
  nombreUsuario: string
  nombre?: string
  apellidoPaterno?: string
  apellidoMaterno?: string
  rfc?: string | null
  telefono?: string | null
  celular?: string | null
  correo?: string
  activo?: boolean
  fotoUsuario?: string | null
  rol?: UsuarioRol
  puesto?: UsuarioPuesto
  idPuesto?: number
  area?: UsuarioArea
}

type CreateFormState = {
  nombreUsuario: string
  nombre: string
  apellidoPaterno: string
  apellidoMaterno: string
  rfc: string
  telefono: string
  celular: string
  correo: string
  rolNombre: string
  idPuesto: string
}

type EditFormState = {
  rolNombre: string
  idPuesto: string
}

function Pill({ ok }: { ok: boolean }) {
  return ok ? (
    <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">
      Sí
    </span>
  ) : (
    <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-red-100 text-red-800">
      No
    </span>
  )
}

function getRolNombre(rol: UsuarioRol | undefined): string {
  if (!rol) return ''
  return typeof rol === 'string' ? rol : rol.nombre ?? ''
}

function getUsuarioPuestoId(u: Usuario): number | undefined {
  if (u.idPuesto != null) return u.idPuesto
  if (u.puesto && typeof u.puesto !== 'string') {
    if (u.puesto.id != null) return u.puesto.id
  }
  return undefined
}

export default function FuncionariosPage() {
  const [q, setQ] = useState('')
  const [createOpen, setCreateOpen] = useState(false)
  const [editOpen, setEditOpen] = useState(false)
  const [confirmActivoOpen, setConfirmActivoOpen] = useState(false)

  const [createForm, setCreateForm] = useState<CreateFormState>({
    nombreUsuario: '',
    nombre: '',
    apellidoPaterno: '',
    apellidoMaterno: '',
    rfc: '',
    telefono: '',
    celular: '',
    correo: '',
    rolNombre: '',
    idPuesto: '',
  })

  const [editForm, setEditForm] = useState<EditFormState>({
    rolNombre: '',
    idPuesto: '',
  })

  const [usuarioSeleccionado, setUsuarioSeleccionado] = useState<Usuario | null>(null)
  const [nuevoActivo, setNuevoActivo] = useState<boolean | null>(null)

  // Usuario para controlar qué popover de reset está abierto
  const [resetUserIdOpen, setResetUserIdOpen] = useState<number | null>(null)

  const queryClient = useQueryClient()

  const usuariosQuery = useQuery({
    queryKey: ['usuarios'],
    queryFn: async () => (await api.get<Usuario[]>('/api/usuarios')).data,
    retry: false,
  })

  const catalogosQuery = useQuery({
    queryKey: ['usuarios', 'catalogos'],
    queryFn: async () => (await api.get<CatalogosResponse>('/api/usuarios/catalogos')).data,
  })

  // 👉 Igual que UsuariosPage, pero filtrando solo FUNCIONARIOS
  const rows = useMemo(
    () =>
      (usuariosQuery.data || [])
        .filter((u) => getRolNombre(u.rol).toLowerCase() === 'funcionario')
        .filter((u) =>
          (
            u.nombreUsuario +
            ' ' +
            (u.nombre || '') +
            ' ' +
            (u.apellidoPaterno || '') +
            ' ' +
            (u.apellidoMaterno || '')
          )
            .toLowerCase()
            .includes(q.toLowerCase()),
        ),
    [usuariosQuery.data, q],
  )

  const resetPasswordMutation = useMutation({
    mutationFn: async ({ id, nueva }: { id: number; nueva: string }) => {
      if (!nueva) {
        throw new Error('Requerida')
      }
      await api.post(`/api/usuarios/${id}/reset-password`, null, { params: { nueva } })
    },
    onSuccess: () => {
      toast.success('Contraseña actualizada')
      setResetUserIdOpen(null)
    },
    onError: (err: unknown) => {
      const msg = axios.isAxiosError(err)
        ? ((err.response?.data as { message?: string })?.message ?? 'No se pudo actualizar')
        : 'No se pudo actualizar'
      toast.error(msg)
    },
  })

  const createUsuarioMutation = useMutation({
    mutationFn: async () => {
      if (!createForm.rolNombre || !createForm.idPuesto) {
        throw new Error('Rol y puesto son obligatorios')
      }
      const payload = {
        nombreUsuario: createForm.nombreUsuario,
        nombre: createForm.nombre,
        apellidoPaterno: createForm.apellidoPaterno,
        apellidoMaterno: createForm.apellidoMaterno,
        rfc: createForm.rfc || null,
        telefono: createForm.telefono,
        celular: createForm.celular,
        correo: createForm.correo,
        rol: createForm.rolNombre,
        idPuesto: Number(createForm.idPuesto),
      }
      await api.post('/api/usuarios', payload)
    },
    onSuccess: () => {
      toast.success('Usuario agregado')
      setCreateOpen(false)
      setCreateForm({
        nombreUsuario: '',
        nombre: '',
        apellidoPaterno: '',
        apellidoMaterno: '',
        rfc: '',
        telefono: '',
        celular: '',
        correo: '',
        rolNombre: '',
        idPuesto: '',
      })
      queryClient.invalidateQueries({ queryKey: ['usuarios'] })
    },
    onError: (err: unknown) => {
      const msg = axios.isAxiosError(err)
        ? ((err.response?.data as { message?: string })?.message ?? 'No se pudo agregar')
        : 'No se pudo agregar'
      toast.error(msg)
    },
  })

  const updateUsuarioMutation = useMutation({
    mutationFn: async () => {
      if (!usuarioSeleccionado) return
      if (!editForm.rolNombre || !editForm.idPuesto) {
        throw new Error('Rol y puesto son obligatorios')
      }
      const payload = {
        rol: editForm.rolNombre,
        idPuesto: Number(editForm.idPuesto),
      }
      await api.patch(`/api/usuarios/${usuarioSeleccionado.id}`, payload)
    },
    onSuccess: () => {
      toast.success('Usuario actualizado')
      setEditOpen(false)
      setUsuarioSeleccionado(null)
      queryClient.invalidateQueries({ queryKey: ['usuarios'] })
    },
    onError: (err: unknown) => {
      const msg = axios.isAxiosError(err)
        ? ((err.response?.data as { message?: string })?.message ?? 'No se pudo actualizar')
        : 'No se pudo actualizar'
      toast.error(msg)
    },
  })

  const cambiarActivoMutation = useMutation({
    mutationFn: async (params: { id: number; activo: boolean }) => {
      const { id, activo } = params
      if (activo) {
        await api.post(`/api/usuarios/${id}/activar`)
      } else {
        await api.post(`/api/usuarios/${id}/desactivar`)
      }
    },
    onSuccess: () => {
      toast.success('Estatus actualizado')
      setConfirmActivoOpen(false)
      setUsuarioSeleccionado(null)
      setNuevoActivo(null)
      queryClient.invalidateQueries({ queryKey: ['usuarios'] })
    },
    onError: (err: unknown) => {
      const msg = axios.isAxiosError(err)
        ? ((err.response?.data as { message?: string })?.message ?? 'No se pudo actualizar estatus')
        : 'No se pudo actualizar estatus'
      toast.error(msg)
    },
  })

  function handleOpenEdit(u: Usuario) {
    setUsuarioSeleccionado(u)
    const currentRol = getRolNombre(u.rol)
    const currentPuestoId = getUsuarioPuestoId(u)
    setEditForm({
      rolNombre: currentRol || '',
      idPuesto: currentPuestoId != null ? String(currentPuestoId) : '',
    })
    setEditOpen(true)
  }

  const puestos = catalogosQuery.data?.puestos ?? []
  const roles = catalogosQuery.data?.roles ?? []

  function getAreaNombreFromPuestoId(idPuestoStr: string): string {
    const id = Number(idPuestoStr)
    if (!id) return ''
    const p = puestos.find((p) => p.id === id)
    return p?.areaNombre ?? ''
  }

  if (usuariosQuery.isError) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Funcionarios</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="text-sm text-red-700 bg-red-50 border border-red-200 rounded p-3">
            Endpoint <code>/api/usuarios</code> no disponible (pendiente en backend).
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <>
      {/* Sheet CREAR FUNCIONARIO (igual que crear usuario) */}
      <Sheet open={createOpen} onOpenChange={setCreateOpen}>
        <Card>
          <CardHeader className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
            <CardTitle>Funcionarios</CardTitle>
            <div className="flex w-full items-center gap-2 md:w-auto">
              <Input
                className="w-full md:w-64"
                placeholder="Buscar por nombre."
                value={q}
                onChange={(e) => setQ(e.target.value)}
              />
              <SheetTrigger asChild>
                <Button size="sm" type="button">
                  <Plus className="mr-1 h-4 w-4" />
                  Agregar
                </Button>
              </SheetTrigger>
            </div>
          </CardHeader>
          <CardContent className="overflow-auto">
            <Table>
              <THead>
                <TR>
                  <TH>Usuario</TH>
                  <TH>Nombre completo</TH>
                  <TH>RFC</TH>
                  <TH>Teléfono</TH>
                  <TH>Celular</TH>
                  <TH>Correo</TH>
                  <TH>Puesto</TH>
                  <TH>Área</TH>
                  <TH>Rol</TH>
                  <TH>Activo</TH>
                  <TH className="w-[200px]" />
                </TR>
              </THead>
              <TBody>
                {rows.map((u) => {
                  const rolNombre = getRolNombre(u.rol)
                  const puestoId = getUsuarioPuestoId(u)
                  const areaNombre =
                    puestoId != null
                      ? getAreaNombreFromPuestoId(String(puestoId))
                      : typeof u.area === 'string'
                      ? u.area
                      : u.area?.nombre ?? ''

                  const puestoNombre =
                    typeof u.puesto === 'string' ? u.puesto : u.puesto?.nombre ?? ''

                  return (
                    <TR key={u.id}>
                      <TD>{u.nombreUsuario}</TD>
                      <TD>
                        {[u.nombre, u.apellidoPaterno, u.apellidoMaterno]
                          .filter(Boolean)
                          .join(' ')}
                      </TD>
                      <TD>{u.rfc}</TD>
                      <TD>{u.telefono}</TD>
                      <TD>{u.celular}</TD>
                      <TD>{u.correo}</TD>
                      <TD>{puestoNombre}</TD>
                      <TD>{areaNombre}</TD>
                      <TD>{rolNombre}</TD>
                      <TD>
                        <button
                          type="button"
                          className="inline-flex items-center gap-1"
                          onClick={() => {
                            setUsuarioSeleccionado(u)
                            setNuevoActivo(!u.activo)
                            setConfirmActivoOpen(true)
                          }}
                        >
                          <Pill ok={Boolean(u.activo)} />
                        </button>
                      </TD>
                      <TD className="flex gap-2">
                        {/* Popover para resetear contraseña */}
                        <Popover
                          open={resetUserIdOpen === u.id}
                          onOpenChange={(open) => setResetUserIdOpen(open ? u.id : null)}
                        >
                          <PopoverTrigger asChild>
                            <Button
                              variant="outline"
                              size="sm"
                              type="button"
                              disabled={resetPasswordMutation.isPending}
                            >
                              Reset contraseña
                            </Button>
                          </PopoverTrigger>
                          <PopoverContent align="end" className="w-72 p-4 space-y-3">
                            <div className="space-y-1">
                              <Label htmlFor={`nuevaContrasena-${u.id}`}>
                                Nueva contraseña
                              </Label>
                              <p className="text-xs text-muted-foreground">
                                Se guardará como SHA-256 en el backend.
                              </p>
                            </div>
                            <form
                              className="space-y-3"
                              onSubmit={(e) => {
                                e.preventDefault()
                                const formData = new FormData(e.currentTarget)
                                const nueva = String(
                                  formData.get('nuevaContrasena') ?? '',
                                ).trim()

                                if (!nueva) {
                                  toast.error('La contraseña es requerida')
                                  return
                                }

                                resetPasswordMutation.mutate({
                                  id: u.id,
                                  nueva,
                                })
                              }}
                            >
                              <Input
                                id={`nuevaContrasena-${u.id}`}
                                name="nuevaContrasena"
                                type="password"
                                autoComplete="new-password"
                                disabled={resetPasswordMutation.isPending}
                              />
                              <div className="flex justify-end gap-2 pt-1">
                                <Button
                                  type="button"
                                  variant="outline"
                                  size="sm"
                                  onClick={() => setResetUserIdOpen(null)}
                                  disabled={resetPasswordMutation.isPending}
                                >
                                  Cancelar
                                </Button>
                                <Button
                                  type="submit"
                                  size="sm"
                                  disabled={resetPasswordMutation.isPending}
                                >
                                  {resetPasswordMutation.isPending && (
                                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                  )}
                                  Guardar
                                </Button>
                              </div>
                            </form>
                          </PopoverContent>
                        </Popover>

                        <Button
                          variant="outline"
                          size="icon"
                          onClick={() => handleOpenEdit(u)}
                          title="Editar rol y puesto"
                        >
                          <SquarePen className="h-4 w-4" />
                        </Button>
                      </TD>
                    </TR>
                  )
                })}
              </TBody>
            </Table>
          </CardContent>
        </Card>

        {/* Sheet CREAR FUNCIONARIO */}
        <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
          <SheetHeader>
            <SheetTitle className="rounded-md bg-primary text-white text-center text-2xl p-3">
              Nuevo funcionario
            </SheetTitle>
            <SheetDescription>
              Registra los datos del nuevo funcionario. El rol y puesto son obligatorios.
            </SheetDescription>
          </SheetHeader>

          <form
            className="mt-4 space-y-4"
            onSubmit={(e) => {
              e.preventDefault()
              createUsuarioMutation.mutate()
            }}
          >
            <div className="space-y-2">
              <Label>Usuario</Label>
              <Input
                value={createForm.nombreUsuario}
                onChange={(e) =>
                  setCreateForm((f) => ({ ...f, nombreUsuario: e.target.value }))
                }
              />
            </div>
            <div className="grid gap-4 sm:grid-cols-2">
              <div className="space-y-2">
                <Label>Nombre</Label>
                <Input
                  value={createForm.nombre}
                  onChange={(e) =>
                    setCreateForm((f) => ({ ...f, nombre: e.target.value }))
                  }
                />
              </div>
              <div className="space-y-2">
                <Label>Apellido paterno</Label>
                <Input
                  value={createForm.apellidoPaterno}
                  onChange={(e) =>
                    setCreateForm((f) => ({
                      ...f,
                      apellidoPaterno: e.target.value,
                    }))
                  }
                />
              </div>
              <div className="space-y-2">
                <Label>Apellido materno</Label>
                <Input
                  value={createForm.apellidoMaterno}
                  onChange={(e) =>
                    setCreateForm((f) => ({
                      ...f,
                      apellidoMaterno: e.target.value,
                    }))
                  }
                />
              </div>
              <div className="space-y-2">
                <Label>RFC</Label>
                <Input
                  value={createForm.rfc}
                  onChange={(e) =>
                    setCreateForm((f) => ({ ...f, rfc: e.target.value }))
                  }
                />
              </div>
            </div>

            <div className="grid gap-4 sm:grid-cols-3">
              <div className="space-y-2">
                <Label>Teléfono</Label>
                <Input
                  value={createForm.telefono}
                  onChange={(e) =>
                    setCreateForm((f) => ({ ...f, telefono: e.target.value }))
                  }
                />
              </div>
              <div className="space-y-2">
                <Label>Celular</Label>
                <Input
                  value={createForm.celular}
                  onChange={(e) =>
                    setCreateForm((f) => ({ ...f, celular: e.target.value }))
                  }
                />
              </div>
              <div className="space-y-2">
                <Label>Correo</Label>
                <Input
                  type="email"
                  value={createForm.correo}
                  onChange={(e) =>
                    setCreateForm((f) => ({ ...f, correo: e.target.value }))
                  }
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label>Rol</Label>
              <Select
                value={createForm.rolNombre}
                onValueChange={(value) =>
                  setCreateForm((f) => ({ ...f, rolNombre: value }))
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona un rol" />
                </SelectTrigger>
                <SelectContent>
                  {roles.map((r) => (
                    <SelectItem key={r.id} value={r.nombre}>
                      {r.nombre}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label>Puesto</Label>
              <Select
                value={createForm.idPuesto}
                onValueChange={(value) =>
                  setCreateForm((f) => ({ ...f, idPuesto: value }))
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona un puesto" />
                </SelectTrigger>
                <SelectContent>
                  {puestos.map((p) => (
                    <SelectItem key={p.id} value={String(p.id)}>
                      {p.nombre}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label>Área</Label>
              <Input
                value={getAreaNombreFromPuestoId(createForm.idPuesto)}
                disabled
                readOnly
              />
            </div>

            <div className="flex justify-end gap-2 pt-4">
              <Button
                type="button"
                variant="outline"
                onClick={() => setCreateOpen(false)}
                disabled={createUsuarioMutation.isPending}
              >
                Cancelar
              </Button>
              <Button type="submit" disabled={createUsuarioMutation.isPending}>
                {createUsuarioMutation.isPending && (
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                )}
                Guardar
              </Button>
            </div>
          </form>
        </SheetContent>
      </Sheet>

      {/* Sheet EDITAR FUNCIONARIO */}
      <Sheet open={editOpen} onOpenChange={setEditOpen}>
        <SheetContent className="overflow-y-auto p-6 sm:p-8 sm:max-w-xl">
          <SheetHeader>
            <SheetTitle className="rounded-md bg-primary text-white text-center text-2xl p-3">
              Editar funcionario
            </SheetTitle>
            <SheetDescription>
              Modifica el rol y el puesto del funcionario seleccionado.
            </SheetDescription>
          </SheetHeader>
          <form
            className="mt-4 space-y-4"
            onSubmit={(e) => {
              e.preventDefault()
              updateUsuarioMutation.mutate()
            }}
          >
            <div className="space-y-2">
              <Label>Usuario</Label>
              <Input
                value={usuarioSeleccionado?.nombreUsuario ?? ''}
                disabled
                readOnly
              />
            </div>
            <div className="space-y-2">
              <Label>Nombre</Label>
              <Input
                value={
                  usuarioSeleccionado
                    ? [
                        usuarioSeleccionado.nombre,
                        usuarioSeleccionado.apellidoPaterno,
                        usuarioSeleccionado.apellidoMaterno,
                      ]
                        .filter(Boolean)
                        .join(' ')
                    : ''
                }
                disabled
                readOnly
              />
            </div>
            <div className="space-y-2">
              <Label>Rol</Label>
              <Select
                value={editForm.rolNombre}
                onValueChange={(value) =>
                  setEditForm((f) => ({ ...f, rolNombre: value }))
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona un rol" />
                </SelectTrigger>
                <SelectContent>
                  {roles.map((r) => (
                    <SelectItem key={r.id} value={r.nombre}>
                      {r.nombre}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Puesto</Label>
              <Select
                value={editForm.idPuesto}
                onValueChange={(value) =>
                  setEditForm((f) => ({ ...f, idPuesto: value }))
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona un puesto" />
                </SelectTrigger>
                <SelectContent>
                  {puestos.map((p) => (
                    <SelectItem key={p.id} value={String(p.id)}>
                      {p.nombre}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Área</Label>
              <Input
                value={getAreaNombreFromPuestoId(editForm.idPuesto)}
                disabled
                readOnly
              />
            </div>
            <div className="flex justify-end gap-2 pt-4">
              <Button
                type="button"
                variant="outline"
                onClick={() => setEditOpen(false)}
                disabled={updateUsuarioMutation.isPending}
              >
                Cancelar
              </Button>
              <Button type="submit" disabled={updateUsuarioMutation.isPending}>
                {updateUsuarioMutation.isPending && (
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                )}
                Guardar cambios
              </Button>
            </div>
          </form>
        </SheetContent>
      </Sheet>

      {/* Diálogo de confirmación de activar/desactivar */}
      <Dialog open={confirmActivoOpen} onOpenChange={setConfirmActivoOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              {nuevoActivo ? 'Activar funcionario' : 'Desactivar funcionario'}
            </DialogTitle>
            <DialogDescription>
              {nuevoActivo
                ? '¿Seguro que deseas activar este funcionario?'
                : '¿Seguro que deseas desactivar este funcionario?'}
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="flex justify-end gap-2">
            <Button
              variant="outline"
              onClick={() => {
                setConfirmActivoOpen(false)
                setUsuarioSeleccionado(null)
                setNuevoActivo(null)
              }}
            >
              Cancelar
            </Button>
            <Button
              onClick={() => {
                if (usuarioSeleccionado && nuevoActivo != null) {
                  cambiarActivoMutation.mutate({
                    id: usuarioSeleccionado.id,
                    activo: nuevoActivo,
                  })
                }
              }}
            >
              {cambiarActivoMutation.isPending && (
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              )}
              Confirmar
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  )
}
