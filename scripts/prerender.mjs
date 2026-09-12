// Prerender every route to static HTML with per-page meta tags.
import { readFileSync, writeFileSync, rmSync, mkdirSync } from 'node:fs'
import { resolve } from 'node:path'
import registry from '../src/data/projects.json' with { type: 'json' }

const dist = resolve(import.meta.dirname, '../dist')
const { render } = await import(resolve(dist, 'server/entry-server.js'))

const template = readFileSync(resolve(dist, 'index.html'), 'utf8')
if (!template.includes('<!--app-html-->')) {
  console.error('dist/index.html is missing the <!--app-html--> marker')
  process.exit(1)
}

const esc = (s) => s.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;')

function page(path, { title, description, image }) {
  let html = template
    .replace(/<title>[^<]*<\/title>/, `<title>${esc(title)}</title>`)
    .replaceAll(/(property="og:title" content=")[^"]*(")/g, `$1${esc(title)}$2`)
    .replaceAll(/(name="twitter:title" content=")[^"]*(")/g, `$1${esc(title)}$2`)
    .replaceAll(/(name="description" content=")[^"]*(")/g, `$1${esc(description)}$2`)
    .replaceAll(/(property="og:description" content=")[^"]*(")/g, `$1${esc(description)}$2`)
    .replaceAll(/(name="twitter:description" content=")[^"]*(")/g, `$1${esc(description)}$2`)
    .replaceAll(/(property="og:url" content=")[^"]*(")/g, `$1https://browse.shiner.app${path}$2`)
    .replaceAll(/(rel="canonical" href=")[^"]*(")/g, `$1https://browse.shiner.app${path}$2`)
  if (image) {
    html = html
      .replace('</head>', `  <meta property="og:image" content="${esc(image)}" />\n  </head>`)
      .replace(/(name="twitter:card" content=")[^"]*(")/, '$1summary_large_image$2')
  }
  return html.replace('<!--app-html-->', render(path))
}

writeFileSync(
  resolve(dist, 'index.html'),
  page('/', {
    title: "Things I've Built — Raymond Shiner",
    description:
      'The canonical registry of everything Raymond Shiner has built — sites, apps, and tools, always current.',
  }),
)

let count = 1
for (const p of registry.projects) {
  const dir = resolve(dist, 'p', p.slug)
  mkdirSync(dir, { recursive: true })
  writeFileSync(
    resolve(dir, 'index.html'),
    page(`/p/${p.slug}/`, {
      title: `${p.title} — Raymond Shiner`,
      description: p.blurb,
      image: p.screenshot_url,
    }),
  )
  count++
}

rmSync(resolve(dist, 'server'), { recursive: true, force: true })
console.log(`Prerendered ${count} pages`)
