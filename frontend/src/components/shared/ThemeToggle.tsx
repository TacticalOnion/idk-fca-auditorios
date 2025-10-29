import { useEffect, useState } from 'react'
import { Sun, Moon } from 'lucide-react'

export function ThemeToggle(){
  const [dark, setDark] = useState<boolean>(false)
  useEffect(()=>{
    document.documentElement.classList.toggle('dark', dark)
    document.body.className = dark ? 'bg-neutral-900 text-neutral-100' : 'bg-white text-neutral-900'
  },[dark])
  return (
    <button onClick={()=> setDark(v=> !v)} className="inline-flex items-center gap-2 rounded-2xl border px-3 py-2">
      {dark? <Sun size={16}/> : <Moon size={16}/>}<span className="text-sm">{dark? 'Claro' : 'Oscuro'}</span>
    </button>
  )
}
