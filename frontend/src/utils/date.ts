import { addMonths, eachDayOfInterval, endOfMonth, format, isAfter, isBefore, isWithinInterval, parseISO, startOfMonth } from 'date-fns'
export const fmtDate = (iso:string)=> format(parseISO(iso), 'yyyy-MM-dd')
export const fmtTime = (hhmm:string)=> hhmm
export function inRange(d:string, start:string, end:string){
  const x = parseISO(d); return isWithinInterval(x, {start: parseISO(start), end: parseISO(end)})
}
export function monthMatrix(isoMonth:string){
  const start = startOfMonth(parseISO(isoMonth+'-01'))
  const end = endOfMonth(start)
  return eachDayOfInterval({start, end})
}
export function nextMonth(isoMonth:string){
  return format(addMonths(parseISO(isoMonth+'-01'), 1), 'yyyy-MM')
}
export function prevMonth(isoMonth:string){
  return format(addMonths(parseISO(isoMonth+'-01'), -1), 'yyyy-MM')
}
export const between = (a:string,b:string,c:string)=> isAfter(parseISO(a), parseISO(b)) && isBefore(parseISO(a), parseISO(c))
