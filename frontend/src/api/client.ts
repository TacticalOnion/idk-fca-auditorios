const BASE = import.meta.env.VITE_API_BASE_URL || "http://localhost:8080";
const BASIC = btoa(`${import.meta.env.VITE_API_USER}:${import.meta.env.VITE_API_PASS}`);

export async function fetchDataset() {
  const res = await fetch(`${BASE}/api/export`, {
    headers: {
      "Accept": "application/json",
      "Authorization": `Basic ${BASIC}`,
    },
  });
  if (!res.ok) throw new Error(`GET /api/export -> HTTP ${res.status}`);
  return res.json();
}

