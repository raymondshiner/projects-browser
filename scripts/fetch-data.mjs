// Build-time fetch: Supabase → src/data/projects.json
// The anon key is public by design (RLS: public read only).
import { mkdirSync, writeFileSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

const SUPABASE_URL = process.env.SUPABASE_URL ?? 'https://hvushymyryulzgifwqhk.supabase.co'
const SUPABASE_ANON_KEY =
  process.env.SUPABASE_ANON_KEY ??
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh2dXNoeW15cnl1bHpnaWZ3cWhrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODkxNzM3NDUsImV4cCI6MjEwNDc0OTc0NX0.LH2-nQvnxQk63bIA7HiqSkIqG2opW8ReMK1l2ok6fBA'

const res = await fetch(
  `${SUPABASE_URL}/rest/v1/projects?select=*&order=sort.asc,created_at.asc`,
  { headers: { apikey: SUPABASE_ANON_KEY, authorization: `Bearer ${SUPABASE_ANON_KEY}` } },
)
if (!res.ok) {
  console.error(`Supabase fetch failed: ${res.status} ${await res.text()}`)
  process.exit(1)
}
const projects = await res.json()
if (!Array.isArray(projects) || projects.length === 0) {
  console.error('Supabase returned no projects — refusing to build an empty index.')
  process.exit(1)
}

const out = { built_at: new Date().toISOString(), projects }
const file = resolve(dirname(fileURLToPath(import.meta.url)), '../src/data/projects.json')
mkdirSync(dirname(file), { recursive: true })
writeFileSync(file, JSON.stringify(out, null, 2))
console.log(`Wrote ${projects.length} projects → src/data/projects.json`)
