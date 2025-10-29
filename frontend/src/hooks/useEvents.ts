import { useEffect, useState } from 'react'
import data from '@/data/events.json'
import type { EventItem } from '@/types/event'

export function useEvents() {
  const [events, setEvents] = useState<EventItem[]>([])
  useEffect(() => {
    setEvents(data as EventItem[])
  }, [])
  return { events, setEvents }
}
