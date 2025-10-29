import { Button } from '@/components/ui/button'

export function ColumnToggle({
  columns, onChange
}:{columns: {key:string; label:string; visible:boolean}[]; onChange:(key:string, visible:boolean)=>void}){
  return (
    <div className="flex flex-wrap gap-2">
      {columns.map(c=> (
        <label key={c.key} className="inline-flex items-center gap-2 text-sm border rounded-xl px-2 py-1">
          <input type="checkbox" checked={c.visible} onChange={(e)=> onChange(c.key, e.target.checked)} /> {c.label}
        </label>
      ))}
      <Button onClick={()=> columns.forEach(c=> onChange(c.key, true))}>Todas</Button>
    </div>
  )
}
