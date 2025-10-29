import { Badge } from '@/components/ui/badge'
import type { EventItem } from '@/types/event'

export function EventBadges({e}:{e:EventItem}){
  return (
    <div className="flex flex-wrap gap-1">
      <Badge>{e.megaEvent}</Badge>
      <Badge>{e.venue}</Badge>
      {e.modalities.map(m=> <Badge key={m}>{m}</Badge>)}
      <Badge>{e.category}</Badge>
    </div>
  )
}
