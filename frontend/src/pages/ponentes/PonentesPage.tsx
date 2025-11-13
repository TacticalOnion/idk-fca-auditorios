import { useQuery } from '@tanstack/react-query'
import { api } from '../../lib/api'
import { Button, Card, CardContent, CardHeader, CardTitle, Input, Table, TBody, TD, TH, THead, TR, Select, SelectItem, SelectTrigger, SelectValue, SelectContent } from '@ui/index'
import { useMemo, useState } from 'react'
import { toast } from 'sonner'
import { Download } from 'lucide-react'

type Row = { id:number, nombre:string, apellido_paterno:string, apellido_materno:string, id_pais:number, semblanzaArchivo?:string }

function SemblanzaPill({ generada }:{ generada:boolean }) {
  return generada
    ? <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-green-100 text-green-800">Generada</span>
    : <span className="inline-flex items-center px-2 py-0.5 rounded text-xs bg-yellow-100 text-yellow-800">Pendiente</span>
}

export default function PonentesPage(){
  const { data } = useQuery({ queryKey:['ponentes'], queryFn: async ()=> (await api.get<Row[]>('/api/ponentes')).data })
  const [q,setQ] = useState(''); const [pais,setPais] = useState<string>('')
  const rows = useMemo(()=> (data||[])
    .filter(p=> (p.nombre+' '+(p.apellido_paterno||'')+' '+(p.apellido_materno||'')).toLowerCase().includes(q.toLowerCase()))
    .filter(p=> !pais || String(p.id_pais)===pais), [data,q,pais])

  async function descargar(ids:number[]){
    try{
      const res = await api.post('/api/ponentes/descargar-semblanzas', { ids }, { responseType:'blob' })
      const url = URL.createObjectURL(res.data)
      const a = document.createElement('a'); a.href = url; a.download = 'semblanzas.zip'; a.click()
      URL.revokeObjectURL(url)
    }catch{ toast.error('Error al descargar') }
  }

  const [selected,setSelected] = useState<number[]>([])
  function toggle(id:number){ setSelected(prev => prev.includes(id) ? prev.filter(x=>x!==id) : [...prev,id]) }

  return (
    <Card>
      <CardHeader className="flex items-center justify-between">
        <CardTitle>Ponentes</CardTitle>
        <div className="flex gap-2 items-center">
          <Input placeholder="Buscar nombre..." value={q} onChange={e=>setQ(e.target.value)} />
          <Select value={pais} onValueChange={setPais}>
            <SelectTrigger><SelectValue placeholder="Todos los países" /></SelectTrigger>
            <SelectContent>
              {/* Si quieres, carga países desde la API */}
              <SelectItem value="">Todos los países</SelectItem>
              <SelectItem value="1">1</SelectItem>
              <SelectItem value="2">2</SelectItem>
            </SelectContent>
          </Select>
          <Button variant="outline" onClick={()=>descargar(selected)} disabled={!selected.length}><Download size={16} className="mr-2"/> Descarga ZIP</Button>
        </div>
      </CardHeader>
      <CardContent className="overflow-auto">
        <Table>
          <THead><TR><TH></TH><TH>Nombre</TH><TH>País</TH><TH>Semblanza</TH><TH></TH></TR></THead>
          <TBody>
            {rows.map(p=>(
              <TR key={p.id}>
                <TD><input type="checkbox" checked={selected.includes(p.id)} onChange={()=>toggle(p.id)} /></TD>
                <TD>{p.nombre} {p.apellido_paterno||''} {p.apellido_materno||''}</TD>
                <TD>{p.id_pais}</TD>
                <TD><SemblanzaPill generada={Boolean(p.semblanzaArchivo)} /></TD>
              </TR>
            ))}
          </TBody>
        </Table>
      </CardContent>
    </Card>
  )
}
