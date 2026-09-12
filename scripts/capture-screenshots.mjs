// Capture 1280x800 screenshots of every project with a live_url,
// upload to the public `screenshots` bucket, and stamp screenshot_url on the row.
// Requires SUPABASE_SERVICE_ROLE_KEY in env (bypasses RLS; never commit it).
import { chromium } from 'playwright'

const SUPABASE_URL = process.env.SUPABASE_URL ?? 'https://hvushymyryulzgifwqhk.supabase.co'
const KEY = process.env.SUPABASE_SERVICE_ROLE_KEY
if (!KEY) {
  console.error('Set SUPABASE_SERVICE_ROLE_KEY (supabase projects api-keys --project-ref hvushymyryulzgifwqhk)')
  process.exit(1)
}
const headers = { apikey: KEY, authorization: `Bearer ${KEY}` }

const res = await fetch(`${SUPABASE_URL}/rest/v1/projects?select=id,slug,live_url&live_url=not.is.null`, { headers })
const projects = await res.json()

const browser = await chromium.launch()
const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 }, deviceScaleFactor: 2 })

for (const p of projects) {
  const page = await ctx.newPage()
  try {
    await page.goto(p.live_url, { waitUntil: 'networkidle', timeout: 30000 })
    await page.waitForTimeout(1500)
    const png = await page.screenshot({ type: 'png' })

    const path = `${p.slug}.png`
    const up = await fetch(`${SUPABASE_URL}/storage/v1/object/screenshots/${path}`, {
      method: 'POST',
      headers: { ...headers, 'content-type': 'image/png', 'x-upsert': 'true' },
      body: png,
    })
    if (!up.ok) throw new Error(`upload ${up.status}: ${await up.text()}`)

    const publicUrl = `${SUPABASE_URL}/storage/v1/object/public/screenshots/${path}`
    const patch = await fetch(`${SUPABASE_URL}/rest/v1/projects?id=eq.${p.id}`, {
      method: 'PATCH',
      headers: { ...headers, 'content-type': 'application/json' },
      body: JSON.stringify({ screenshot_url: publicUrl }),
    })
    if (!patch.ok) throw new Error(`patch ${patch.status}`)
    console.log(`OK    ${p.slug} → ${publicUrl}`)
  } catch (e) {
    console.log(`SKIP  ${p.slug} — ${String(e.message ?? e).split('\n')[0]}`)
  } finally {
    await page.close()
  }
}

await browser.close()
