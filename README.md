# projects-browser

The canonical registry of everything I've built — live at **[browse.shiner.app](https://browse.shiner.app)**.

Projects live in a Supabase table; the site is **static HTML prerendered at build time**. A Supabase
database webhook fires a Cloudflare Pages deploy hook whenever a row changes, so adding a project is
just adding a row — no rebuild, no redeploy, no git push.

## How it works

```
Supabase projects table ──(row change)──▶ webhook ──▶ Cloudflare deploy hook
        │                                                     │
        └──(build-time fetch)──▶ npm run build ◀──────────────┘
                                      │
                     fetch-data → vite build → SSR prerender
                                      │
                                dist/ (static HTML, hydrated on load)
```

- `scripts/fetch-data.mjs` — pulls the registry into `src/data/projects.json` (anon key, public-read RLS)
- `scripts/prerender.mjs` — injects the server-rendered app into `dist/index.html`
- `scripts/capture-screenshots.mjs` — Playwright captures of each live URL → Supabase Storage
- `tests/verify-ui.mjs` — desktop + iPhone 13 assertions, static-HTML + WCAG AA contrast checks

## Stack

React 19 · TypeScript strict · Vite · Tailwind v4 · shadcn/ui · Supabase · Cloudflare Pages ·
Andromeda theme

## Commands

```bash
npm run dev          # fetches fresh data, starts dev server
npm run build        # fetch → typecheck → build → prerender
npm run verify-ui    # Playwright verification against dist/
npm run screenshots  # capture + upload project screenshots (needs SUPABASE_SERVICE_ROLE_KEY)
```
