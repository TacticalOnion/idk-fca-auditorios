export function downloadFile(filename: string, content: string, mime: string = 'text/plain') {
  const blob = new Blob([content], { type: mime })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = filename
  a.click()
  URL.revokeObjectURL(url)
}

// Versión genérica y tipada de toCSV (sin any)
export function toCSV<T extends Record<string, unknown>>(rows: T[]): string {
  if (rows.length === 0) return ''

  // columnas a partir de la primera fila
  const cols = Object.keys(rows[0] as Record<string, unknown>)

  const escapeVal = (v: unknown) => `"${String(v ?? '').replace(/"/g, '""')}"`

  const lines = [
    cols.join(','),
    ...rows.map((r) =>
      cols
        .map((c) => escapeVal((r as Record<string, unknown>)[c]))
        .join(',')
    ),
  ]

  return lines.join('\n')
}
