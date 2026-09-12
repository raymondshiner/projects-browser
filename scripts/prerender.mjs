// Inject server-rendered markup into the built index.html.
import { readFileSync, writeFileSync, rmSync } from 'node:fs'
import { resolve } from 'node:path'

const dist = resolve(import.meta.dirname, '../dist')
const { render } = await import(resolve(dist, 'server/entry-server.js'))

const htmlFile = resolve(dist, 'index.html')
const template = readFileSync(htmlFile, 'utf8')
if (!template.includes('<!--app-html-->')) {
  console.error('dist/index.html is missing the <!--app-html--> marker')
  process.exit(1)
}
const html = template.replace('<!--app-html-->', render())
writeFileSync(htmlFile, html)
rmSync(resolve(dist, 'server'), { recursive: true, force: true })
console.log('Prerendered dist/index.html')
