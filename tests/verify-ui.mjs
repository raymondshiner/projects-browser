// Headless UI verification — drives Playwright against the built site (or BASE_URL).
// Usage: npm run build && node tests/verify-ui.mjs
import { createServer } from 'node:http'
import { readFileSync, existsSync, mkdirSync } from 'node:fs'
import { resolve, extname, join } from 'node:path'
import { chromium, devices } from 'playwright'
import registry from '../src/data/projects.json' with { type: 'json' }

const SHOTS = '/tmp/projects-browser-shots'
mkdirSync(SHOTS, { recursive: true })

const results = []
const record = (name, ok, detail = '') => {
  results.push({ name, ok, detail })
  console.log(`${ok ? 'PASS' : 'FAIL'}  ${name}${detail ? ` — ${detail}` : ''}`)
}

// Serve dist/ unless BASE_URL points elsewhere
let BASE = process.env.BASE_URL
let server
if (!BASE) {
  const dist = resolve(import.meta.dirname, '../dist')
  const types = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css', '.svg': 'image/svg+xml', '.png': 'image/png', '.json': 'application/json' }
  server = createServer((req, res) => {
    let file = join(dist, req.url.split('?')[0])
    if (file.endsWith('/')) file += 'index.html'
    if (!existsSync(file)) file = join(dist, 'index.html')
    res.setHeader('content-type', types[extname(file)] ?? 'application/octet-stream')
    res.end(readFileSync(file))
  }).listen(4180)
  BASE = 'http://localhost:4180/'
}

// contrast helper (WCAG relative luminance)
const lum = (hex) => {
  const [r, g, b] = [1, 3, 5].map((i) => parseInt(hex.slice(i, i + 2), 16) / 255)
    .map((c) => (c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4))
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
}
const contrast = (a, b) => {
  const [l1, l2] = [lum(a), lum(b)].sort((x, y) => y - x)
  return (l1 + 0.05) / (l2 + 0.05)
}

async function verify(label, browser, options) {
  const ctx = await browser.newContext(options)
  const page = await ctx.newPage()
  const errors = []
  page.on('pageerror', (err) => errors.push(err.message))
  await page.goto(BASE, { waitUntil: 'networkidle' })

  const heading = await page.getByRole('heading', { level: 1 }).textContent()
  record(`${label}/h1`, /Things I.?ve built/i.test(heading ?? ''), heading?.trim())

  const cards = page.getByRole('article')
  const count = await cards.count()
  record(`${label}/all ${registry.projects.length} cards render`, count === registry.projects.length, `got ${count}`)

  for (const p of registry.projects.filter((p) => p.live_url).slice(0, 3)) {
    const link = page.getByRole('main').getByRole('link', { name: p.title, exact: true })
    const href = await link.getAttribute('href')
    record(`${label}/live link ${p.slug}`, href === p.live_url, href ?? 'missing')
  }

  const contentInfo = await page.getByRole('contentinfo').textContent()
  record(`${label}/last-built timestamp`, /last built \d{4}-\d{2}-\d{2}/.test(contentInfo ?? ''), contentInfo?.trim().slice(0, 60))

  record(`${label}/no console errors`, errors.length === 0, errors[0] ?? '')
  await page.screenshot({ path: `${SHOTS}/${label}.png`, fullPage: true })
  await ctx.close()
}

// static-HTML check: content must exist without JS
const noJs = await (await fetch(BASE)).text()
record('static/prerendered content', noJs.includes('Momir Card Printer') && noJs.includes('<article'))
record('static/og tags', noJs.includes('og:title') && noJs.includes('og:description'))

// WCAG AA contrast on the Andromeda tokens actually used for text
record('a11y/muted-foreground contrast ≥4.5', contrast('#8a95ab', '#1c1e26') >= 4.5, contrast('#8a95ab', '#1c1e26').toFixed(2))
record('a11y/foreground contrast ≥4.5', contrast('#d5ced9', '#1c1e26') >= 4.5, contrast('#d5ced9', '#1c1e26').toFixed(2))
record('a11y/primary-on-bg contrast ≥4.5', contrast('#00e8c6', '#1c1e26') >= 4.5, contrast('#00e8c6', '#1c1e26').toFixed(2))

const browser = await chromium.launch()
await verify('desktop', browser, { viewport: { width: 1440, height: 900 } })
await verify('iphone13', browser, { ...devices['iPhone 13'] })
await browser.close()
server?.close()

const failed = results.filter((r) => !r.ok)
console.log(`\n${results.length - failed.length}/${results.length} passed — screenshots in ${SHOTS}`)
process.exit(failed.length ? 1 : 0)
