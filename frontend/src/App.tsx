import React, { useMemo, useState, useContext, createContext } from "react"
import { BrowserRouter, Routes, Route, Link, Navigate, useParams, useLocation } from "react-router-dom"
import './App.css'

type Json = string | number | boolean | null | { [key: string]: Json } | Json[];
type Row = Record<string, Json>;
type DataSet = Record<string, Row[]>;

type RefSpec = {
  targetTable: string;
  targetKey?: string;
  sourceKey?: string;
  displayFields: string[];
  separator?: string;
  format?: (resolved: string, refRow?: Row) => string;
};

type TableSpec = {
  preferColumns?: string[];
  hide?: string[];
  refs?: Record<string, RefSpec>;
  computed?: Record<string, (row: Row, data: DataSet) => string | number | null>;
};

/** MAPEO COMPLETO DE TABLAS Y FKs (según tu requerimiento) */
const TABLES: Record<string, TableSpec> = {
  // Catálogos
  permiso: {
    computed: { permiso: (r) => `${r.recurso} · ${r.accion} · ${r.alcance}` },
    preferColumns: ["permiso", "descripcion", "recurso", "accion", "alcance"],
    hide: ["id_permiso"],
  },
  rol_usuario: { hide: ["id_rol_usuario"], preferColumns: ["nombre"] },
  area: { hide: ["id_area"], preferColumns: ["nombre", "nombre_responsable", "correo_responsable", "activo"] },
  rol_participacion: { hide: ["id_rol_participacion"], preferColumns: ["nombre"] },
  nivel: { hide: ["id_nivel"], preferColumns: ["nombre", "siglas"] },
  institucion: { hide: ["id_institucion"], preferColumns: ["nombre", "siglas"] },
  categoria: { hide: ["id_categoria"], preferColumns: ["nombre"] },
  pais: { hide: ["id_pais"], preferColumns: ["nombre"] },
  tipo: { hide: ["id_tipo"], preferColumns: ["nombre"] },

  // puesto: id_area = area(nombre)
  puesto: {
    refs: { id_area: { targetTable: "area", displayFields: ["nombre"] } },
    hide: ["id_puesto"],
    preferColumns: ["nombre", "activo", "id_area"],
  },

  // usuario: id_rol_usuario = rol_usuario(nombre), id_puesto = puesto(nombre)
  usuario: {
    refs: {
      id_rol_usuario: { targetTable: "rol_usuario", displayFields: ["nombre"] },
      id_puesto: { targetTable: "puesto", displayFields: ["nombre"] },
    },
    computed: { nombre_completo: (r) => `${r.nombre} ${r.apellido_paterno} ${r.apellido_materno}`.trim() },
    hide: ["id_usuario", "contrasenia", "rfc", "telefono", "celular", "foto_usuario"],
    preferColumns: ["nombre_usuario", "nombre_completo", "correo", "activo", "id_rol_usuario", "id_puesto"],
  },

  // evento: id_categoria = categoria(nombre), id_mega_evento = evento(nombre)
  evento: {
    refs: {
      id_categoria: { targetTable: "categoria", displayFields: ["nombre"] },
      id_mega_evento: { targetTable: "evento", displayFields: ["nombre"] },
    },
    hide: ["id_evento"],
    preferColumns: [
      "nombre",
      "descripcion",
      "fecha_inicio",
      "fecha_fin",
      "horario_inicio",
      "horario_fin",
      "presencial",
      "online",
      "mega_evento",
      "id_categoria",
      "id_mega_evento",
    ],
  },

  // integrante
  integrante: {
    computed: { nombre_completo: (r) => `${r.nombre} ${r.apellido_paterno} ${r.apellido_materno}`.trim() },
    hide: ["id_integrante"],
    preferColumns: ["nombre_completo", "semblanza"],
  },

  // grado: id_nivel = nivel(nombre), id_institucion = institucion(nombre), id_pais = pais(nombre)
  grado: {
    refs: {
      id_nivel: { targetTable: "nivel", displayFields: ["nombre"] },
      id_institucion: { targetTable: "institucion", displayFields: ["nombre"] },
      id_pais: { targetTable: "pais", displayFields: ["nombre"] },
    },
    hide: ["id_grado"],
    preferColumns: ["titulo", "id_nivel", "id_institucion", "id_pais"],
  },

  // integrantexgrado: id_integrante = integrante(...), id_grado = grado(titulo)
  integrantexgrado: {
    refs: {
      id_integrante: { targetTable: "integrante", displayFields: ["nombre", "apellido_paterno", "apellido_materno"] },
      id_grado: { targetTable: "grado", displayFields: ["titulo"] },
    },
    preferColumns: ["id_integrante", "id_grado"],
  },

  // rolxpermiso: id_rol_usuario = rol_usuario(nombre), id_permiso = permiso(recurso,accion,alcance)
  rolxpermiso: {
    refs: {
      id_rol_usuario: { targetTable: "rol_usuario", displayFields: ["nombre"] },
      id_permiso: { targetTable: "permiso", displayFields: ["recurso", "accion", "alcance"], separator: " · " },
    },
    preferColumns: ["id_rol_usuario", "id_permiso"],
  },

  // evento_organizador: id_evento = evento(nombre), id_usuario = usuario(...)
  evento_organizador: {
    refs: {
      id_evento: { targetTable: "evento", displayFields: ["nombre"] },
      id_usuario: { targetTable: "usuario", displayFields: ["nombre", "apellido_paterno", "apellido_materno"] },
    },
    preferColumns: ["id_evento", "id_usuario", "confirmacion", "numero_registro"],
  },

  // participacion: id_evento = evento(nombre), id_integrante = integrante(...), id_rol_participacion = rol_participacion(nombre)
  participacion: {
    refs: {
      id_evento: { targetTable: "evento", displayFields: ["nombre"] },
      id_integrante: { targetTable: "integrante", displayFields: ["nombre", "apellido_paterno", "apellido_materno"] },
      id_rol_participacion: { targetTable: "rol_participacion", displayFields: ["nombre"] },
    },
    preferColumns: ["id_evento", "id_integrante", "id_rol_participacion", "numero_registro"],
  },

  // reservacion: id_evento = evento(nombre), id_recinto = recinto(nombre)
  reservacion: {
    refs: {
      id_evento: { targetTable: "evento", displayFields: ["nombre"] },
      id_recinto: { targetTable: "recinto", displayFields: ["nombre"] },
    },
    preferColumns: ["id_evento", "id_recinto", "estatus", "fecha_solicitud", "numero_registro"],
  },

  // reservacionxequipamiento: id_evento, id_recinto, id_equipamiento
  reservacionxequipamiento: {
    refs: {
      id_evento: { targetTable: "evento", displayFields: ["nombre"] },
      id_recinto: { targetTable: "recinto", displayFields: ["nombre"] },
      id_equipamiento: { targetTable: "equipamiento", displayFields: ["nombre"] },
    },
    preferColumns: ["id_evento", "id_recinto", "id_equipamiento", "cantidad"],
  },

  // equipamiento: id_area = area(nombre)
  equipamiento: {
    refs: { id_area: { targetTable: "area", displayFields: ["nombre"] } },
    hide: ["id_equipamiento"],
    preferColumns: ["nombre", "activo", "id_area"],
  },

  // area_inventario: id_area, id_equipamiento
  area_inventario: {
    refs: {
      id_area: { targetTable: "area", displayFields: ["nombre"] },
      id_equipamiento: { targetTable: "equipamiento", displayFields: ["nombre"] },
    },
    preferColumns: ["id_area", "id_equipamiento", "cantidad", "numero_registro"],
  },

  // recinto: id_tipo = tipo(nombre)
  recinto: {
    refs: { id_tipo: { targetTable: "tipo", displayFields: ["nombre"] } },
    hide: ["id_recinto"],
    preferColumns: ["nombre", "aforo", "latitud", "longitud", "croquis", "activo", "id_tipo"],
  },

  // recinto_inventario: id_recinto, id_equipamiento
  recinto_inventario: {
    refs: {
      id_recinto: { targetTable: "recinto", displayFields: ["nombre"] },
      id_equipamiento: { targetTable: "equipamiento", displayFields: ["nombre"] },
    },
    preferColumns: ["id_recinto", "id_equipamiento", "cantidad", "numero_registro"],
  },

  // fotografia: id_recinto = recinto(nombre)
  fotografia: {
    refs: { id_recinto: { targetTable: "recinto", displayFields: ["nombre"] } },
    hide: ["id_fotografia"],
    preferColumns: ["fotografia", "id_recinto"],
  },

  // auditoria: id_usuario = usuario(...)
  auditoria: {
    refs: { id_usuario: { targetTable: "usuario", displayFields: ["nombre", "apellido_paterno", "apellido_materno"] } },
    hide: ["id_auditoria"],
    preferColumns: [
      "nombre_tabla",
      "id_registro_afectado",
      "accion",
      "campo_modificado",
      "valor_anterior",
      "valor_nuevo",
      "id_usuario",
      "fecha_hora",
    ],
  },
};

// Utils -------------------------------------------------
function inferIdKey(row: Row): string | undefined {
  return Object.keys(row).find((k) => k.startsWith("id_"));
}

// Resolución de FKs con fallback a objeto embebido (si no hay id_*)
function resolveRef(field: string, row: Row, data: DataSet, spec?: RefSpec): string | number | null {
  if (!spec) {
    const val = row[field];
    if (val === null || val === undefined) return null;
    if (typeof val === "string" || typeof val === "number") return val;
    return String(val);
  }

  const sourceKey = spec.sourceKey ?? field; // normalmente: id_area
  const fkValue = row[sourceKey];

  // Si no hay FK numérica, probar objeto embebido: { area: { nombre: "Actos" } }
  if (fkValue === undefined || fkValue === null) {
    const alias = sourceKey.replace(/^id_/, "");
    const embedded = row[alias] as Record<string, Json> | undefined;
    if (embedded && typeof embedded === "object") {
      const sep = spec.separator ?? " ";
      const resolved = spec.displayFields.map((f) => String(embedded[f] ?? "")).join(sep).trim();
      return resolved || null;
    }
  }

  // Resolver por id contra la tabla target
  if (fkValue !== undefined && fkValue !== null) {
    const targetRows = data[spec.targetTable] || [];
    const sample = targetRows[0];
    const targetKey = spec.targetKey ?? (sample ? inferIdKey(sample) : undefined) ?? "id";
    const refRow = targetRows.find((r) => String(r[targetKey]) === String(fkValue));
    if (!refRow) {
      if (typeof fkValue === "string" || typeof fkValue === "number") return fkValue;
      return null;
    }
    const sep = spec.separator ?? " ";
    const resolved = spec.displayFields.map((f) => String(refRow[f] ?? "")).join(sep).trim();
    return spec.format ? spec.format(resolved, refRow) : resolved;
  }

  return null;
}

function makeDisplayRow(row: Row, data: DataSet, tableSpec: TableSpec): Row {
  const refs = tableSpec.refs ?? {};
  const computed = tableSpec.computed ?? {};
  const hide = new Set([...(tableSpec.hide ?? [])]);
  Object.keys(refs).forEach((k) => hide.add(k));

  const out: Row = {};

  // Calculadas
  for (const [name, fn] of Object.entries(computed)) out[name] = fn(row, data);

  // FKs resueltas
  for (const [field, refSpec] of Object.entries(refs)) {
    out[field.replace(/^id_/, "")] = resolveRef(field, row, data, refSpec);
  }

  // Campos visibles restantes
  for (const [k, v] of Object.entries(row)) if (!hide.has(k)) out[k] = v;

  // Reordenado
  const order = tableSpec.preferColumns ?? [];
  const ordered: Row = {};
  for (const key of order) if (key in out) ordered[key] = out[key];
  for (const [k, v] of Object.entries(out)) if (!(k in ordered)) ordered[k] = v;

  return ordered;
}

// Contexto global ---------------------------------------
const DataCtx = createContext<{
  data: DataSet;
  setData: React.Dispatch<React.SetStateAction<DataSet>>;
  fileName: string;
  setFileName: React.Dispatch<React.SetStateAction<string>>;
  success: boolean;
  setSuccess: React.Dispatch<React.SetStateAction<boolean>>;
}>({ data: {}, setData: () => {}, fileName: "", setFileName: () => {}, success: false, setSuccess: () => {} });

function useData() {
  return useContext(DataCtx);
}


// UI ----------------------------------------------------
function Badge({ children }: { children: React.ReactNode }) {
  return <span className="inline-block rounded-full border px-2 py-0.5 text-xs text-gray-700">{children}</span>;
}

function Card({ title, children, extra }: { title: string; children: React.ReactNode; extra?: React.ReactNode }) {
  return (
    <div className="rounded-2xl border bg-white shadow-sm">
      <div className="flex items-center justify-between border-b p-4">
        <h2 className="text-lg font-semibold">{title}</h2>
        {extra}
      </div>
      <div className="p-4">{children}</div>
    </div>
  );
}

function TableView({ rows }: { rows: Row[] }) {
  const cols = useMemo(() => (rows[0] ? Object.keys(rows[0]) : []), [rows]);
  return (
    <div className="overflow-auto rounded-xl border">
      <table className="min-w-full text-sm">
        <thead className="bg-gray-50">
          <tr>
            {cols.map((c) => (
              <th key={c} className="px-3 py-2 text-left font-medium text-gray-600">
                {c}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rows.map((r, i) => (
            <tr key={i} className="odd:bg-white even:bg-gray-50">
              {cols.map((c) => (
                <td key={c} className="px-3 py-2">
                  {formatValue(r[c])}
                </td>
              ))}
            </tr>
          ))}
          {rows.length === 0 && (
            <tr>
              <td className="p-6 text-center text-gray-500" colSpan={cols.length}>
                Sin datos
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
}

function pluralPathOf(table: string) {
  return `/${table}${table.endsWith("s") ? "" : "s"}`;
}
function humanLabel(table: string) {
  return table.replaceAll("_", " ").replace(/^./, (c) => c.toUpperCase());
}

function GlobalLoader() {
  const { setData, setFileName, setSuccess } = useData();
  async function handleFile(file: File) {
    const text = await file.text();
    try {
      const parsed = JSON.parse(text);
      if (!parsed || typeof parsed !== "object") throw new Error("JSON inválido");
      setData(parsed);
      setFileName(file.name);
      setSuccess(true);
      setTimeout(() => setSuccess(false), 3000);
    } catch (e) {
      alert(`No se pudo leer el JSON: ${(e as Error).message}`);
    }
  }
  return (
    <label className="inline-flex cursor-pointer items-center gap-2 rounded-xl border px-3 py-2 hover:bg-gray-50">
      <input
        type="file"
        accept="application/json"
        className="hidden"
        onChange={(e) => {
          const f = e.target.files?.[0];
          if (f) handleFile(f);
        }}
      />
      <span>Cargar JSON…</span>
    </label>
  );
}

function Layout({ children }: { children: React.ReactNode }) {
  const { data, fileName, success } = useData();
  const presentTables = useMemo(
    () => (Object.keys(data).length ? Object.keys(data).sort() : Object.keys(TABLES).sort()),
    [data]
  );
  const location = useLocation();
  return (
    <div className="mx-auto max-w-7xl p-6">
      <header className="mb-6 flex flex-col gap-2 md:flex-row md:items-center md:justify-between">
        <div>
          <div className="flex items-center space-x-3">
            <img src="/idk-logo.svg" alt="Logo FCA" className="w-8 h-8" />
            <h1 className="text-2xl font-bold">FCA Auditorios</h1>
          </div>
          <p className="text-gray-600">Cada tabla tiene su propia ruta. Sube un JSON global.</p>
          {fileName && (
            <p className="text-sm text-gray-700">
              Archivo cargado: <strong>{fileName}</strong>
            </p>
          )}
          {success && <p className="text-sm text-green-600 font-semibold">✅ Archivo cargado exitosamente</p>}
        </div>
        <GlobalLoader />
      </header>
      <div className="grid grid-cols-1 gap-6 md:grid-cols-12">
        <aside className="md:col-span-3 lg:col-span-2">
          <Card title="Tablas" extra={<Badge>{presentTables.length}</Badge>}>
            <nav className="flex flex-col gap-1">
              {presentTables.map((t) => (
                <Link
                  key={t}
                  to={pluralPathOf(t)}
                  className={`rounded-lg px-3 py-2 hover:bg-gray-50 overflow-hidden text-ellipsis whitespace-nowrap${
                    location.pathname === pluralPathOf(t) ? "bg-gray-50 font-medium" : ""
                  }`}
                >
                  {humanLabel(t)}
                </Link>
              ))}
            </nav>
          </Card>
        </aside>
        <main className="md:col-span-9 lg:col-span-10 ">{children}</main>
      </div>
    </div>
  );
}

function formatValue(value: Json): string {
  if (value === null || value === undefined) return "";
  if (typeof value === "string" || typeof value === "number" || typeof value === "boolean")
    return String(value);

  if (Array.isArray(value)) {
    // Si es un arreglo, formatea cada elemento recursivamente
    return value.map(formatValue).join(", ");
  }

  if (typeof value === "object") {
    // Solo imprime los valores, separados por espacios
    return Object.values(value)
      .map(formatValue)
      .join(" ")
      .trim();
  }

  return String(value);
}

function TablePage() {
  const { data } = useData();
  const rawKey = useParams<{ table: string }>().table ?? "";

  // Clave para TABLES (spec) y para DATA (filas)
  function singularCandidates(word: string) {
    const base = word.toLowerCase();
    const cands = new Set<string>([
      base,
      base.replace(/es$/, ""), // actores -> actor, recintos -> recinto (si terminan en -es)
      base.replace(/s$/, ""),  // areas -> area, eventos -> evento
    ]);
    // extras comunes
    if (base.endsWith("iones")) cands.add(base.slice(0, -4) + "ión"); // regiones -> región
    if (base.endsWith("ces")) cands.add(base.slice(0, -3) + "z");     // luces -> luz
    return Array.from(cands);
  }

  // Resolver claves para SPEC (TABLES) y DATA (JSON cargado)
  const candidates = singularCandidates(rawKey);

  // 1) specKey (tus definiciones están en singular)
  const specKey = candidates.find((c) => TABLES[c]) ?? candidates[candidates.length - 1] ?? rawKey;

  // 2) dataKey (tu JSON viene en singular; si un día viniera en plural, también funcionará)
  const dataKey =
    candidates.find((c) => data && typeof data === "object" && c in data) ??
    candidates[candidates.length - 1] ??
    rawKey;

  const spec = TABLES[specKey] ?? {};
  const srcRows = (data as Record<string, Row[] | undefined>)[dataKey] ?? [];
  const rows = Array.isArray(srcRows) ? srcRows.map((row) => makeDisplayRow(row, data, spec)) : [];
  
  return (
    <Card title={`${humanLabel(specKey)} ${dataKey !== specKey ? `(${dataKey})` : ""}`} extra={<Badge>{rows.length} filas</Badge>}>
      {Object.keys(data).length === 0 ? (
        <div className="text-gray-500">Aún no has cargado un JSON.</div>
      ) : srcRows.length === 0 ? (
        <div className="text-gray-500">
          No se encontraron datos para esta tabla.
          <div className="mt-2 text-xs">
            Revisa que tu JSON tenga una clave <code>{specKey}</code> o <code>{specKey}s</code> (o el nombre que estés usando para esta tabla).
          </div>
        </div>
      ) : (
        <TableView rows={rows} />
      )}
    </Card>
  );
}

function Home() {
  return (
    <Card title="Bienvenido">
      <p>
        Sube tu archivo JSON y navega a la tabla deseada (por ejemplo, <code>/eventos</code>, <code>/areas</code>, ...).
      </p>
      <p className="text-xs text-gray-600 mt-2">
        El JSON debe tener el shape: <code>{`{ "tabla": [ { ... }, ... ] }`}</code> en singular por regla interna. Si
        anidas objetos (p. ej. <code>area: {"{ nombre }"}</code>) también se resolverán.
      </p>
    </Card>
  );
}

function App() {
  const [data, setData] = useState<DataSet>({});
  const [fileName, setFileName] = useState("");
  const [success, setSuccess] = useState(false);

  return (
    <DataCtx.Provider value={{ data, setData, fileName, setFileName, success, setSuccess }}>
      <BrowserRouter>
        <Layout>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/:table" element={<TablePage />} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </Layout>
      </BrowserRouter>
    </DataCtx.Provider>
  )
}

export default App
