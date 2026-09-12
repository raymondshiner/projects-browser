# projects-browser

> Planning doc. Edit before shipping Cycle 1. Cycles ship as feature branches → PRs.

**Live at:** `browse.shiner.app` (apex `shiner.app` registered 2026-09-11, Cloudflare Registrar)

## Vision

One canonical, always-current list of **everything Raymond has built** — personal projects and
Shiner Software client work in the same registry — published at `browse.shiner.app`.

It solves a real maintenance problem: today the portfolio story is duplicated by hand across
`raymondshiner.com` (3 MDX case studies) and the Shiner Software site, and adding a project means
editing and redeploying each one. Here, projects live in **Supabase**, so adding one is a row —
no rebuild, no redeploy, no git push.

`shiner.app` is an **umbrella for live apps** (`<name>.shiner.app`). `browse` is its front door:
part portfolio, part launcher. Over time the apps in `~/src` migrate onto subdomains and `browse`
becomes the directory that launches them. The umbrella is already real — **`momir.shiner.app` shipped
2026-09-11** on Cloudflare Pages, so it is the first entry that gets a launch card rather than a repo link.

## Non-goals

- **Not a replacement for `rshiner-website-v3`.** That stays the personal brand site with its
  narrative case studies. This is the exhaustive index, not the story.
- **Not a CMS.** No rich-text editor, no drafts/workflow, no multi-author. One person, one table.
- **Not an analytics or project-management tool.** No time tracking, no status boards, no ops log —
  that already lives in `~/jarvis/claude/project-logs/`.
- **No client-confidential content.** Client work appears only at the level a public case study
  would — name, scope, link. Nothing under NDA.
- ~~**Not blog/long-form.** Entries are cards, not essays. Deep narrative links out to a case study.~~
  **Reversed 2026-09-11:** case studies moved INTO this site — each project has a `/p/<slug>/` detail
  page (case study + how-it-was-built, `details_md` markdown column). This site is now the narrative
  home; v3's case-study pages become redirect candidates (Cycle 3 work).
- **No auth for visitors.** Fully public read; the only gated surface is the admin write path.

## Stack

Defaults from `~/src/CLAUDE.md` (Vite + React 19 + TS strict, Tailwind v4, shadcn/ui Radix Nova).

- **Build:** Vite + React 19 + TypeScript (strict)
- **UI:** Tailwind v4 + shadcn/ui (Radix Nova), Andromeda palette to match the desktop and v3
- **Data:** Supabase (Postgres + RLS, public read / authenticated write) + Supabase Storage for screenshots
- **Live signals:** GitHub API for last-push / language / stars — crib `api/github-activity.ts` from
  `rshiner-website-v3`
- **Rendering:** **static prerender + deploy hook** (decided 2026-09-11). Pages are built to plain
  HTML at build time; a Supabase webhook fires a Cloudflare **deploy hook** whenever a `projects` row
  changes, so the site rebuilds itself (~1 min) with no human action. No SSR, no runtime Supabase
  fetch on the critical path.
- **Hosting:** Cloudflare Pages — domain, DNS, and deploy in one account; matches the Shiner
  Software stack default
- **Overrides / reasons:** Cloudflare Pages instead of the usual Vercel default, because the apex is
  already at Cloudflare Registrar and the umbrella will want many subdomains under one roof.

### Content model — hybrid

The Supabase row is the source of truth for **what appears and how it reads** (title, blurb, tags,
links, screenshot, personal-vs-professional flag). GitHub layers **live signals** on at runtime.
Hand-written copy wins; the API only decorates.

## Cycles

### Cycle 1 — MVP: the public index

**Theme:** A real, browsable, always-current list of everything built — editable without a deploy.

**Done when:**
- [ ] Supabase schema live (`projects` table + RLS: public read, authenticated write) with fields for
      title, slug, blurb, tags, stack, links, screenshot, category (`personal` | `professional`), status, sort
- [ ] Registry seeded with every shipped project from `~/src` plus client work
- [ ] `browse.shiner.app` renders the full index as **static HTML** (crawler- and social-card-safe),
      built from Supabase at build time
- [ ] Supabase webhook → Cloudflare deploy hook wired: adding a row republishes the site with **no
      human action**, verified end to end
- [ ] Each card shows title, blurb, stack chips, screenshot, and working links (live / repo / case study)
- [ ] Deployed to Cloudflare Pages on `browse.shiner.app` with HTTPS (`.app` is HSTS-preloaded)
- [ ] `verify-ui.mjs` passes — desktop + iPhone 13, `getByRole`, WCAG AA contrast

**Scope:**
- Schema design and seed
- Index page: responsive grid of project cards
- Build-time Supabase fetch + graceful empty/error states
- Per-project Open Graph / Twitter card meta tags (the whole point of going static)
- Andromeda theming consistent with v3

**Out of scope for this cycle (deferred):**
- Admin UI (seed via SQL/script for now)
- Personal/professional toggle (the flag is stored from day one; the UI filter waits until there's
  enough of each to be worth separating)
- GitHub live-signal decoration
- Public JSON API for the other two sites
- App-launcher behavior / subdomain migration

### Cycle 2 — Authoring without a keyboard

**Theme:** Add a project from my phone in under a minute.

**Done when:**
- [ ] Password- or Google-SSO-gated admin route to create/edit/reorder projects
- [ ] Screenshot upload straight to Supabase Storage
- [ ] Installable PWA (per `~/src/CLAUDE.md` delivery default)

### Cycle 3 — Syndication

**Theme:** One registry, three sites.

- `raymondshiner.com` and the Shiner Software site each link out to it (moved from Cycle 1 — it's
  work in *other* repos, not this one)
- Public cached JSON endpoint as a stable contract
- `raymondshiner.com` renders the index in its own design
- Shiner Software site renders the professional-filtered subset
- Personal/professional toggle ships in the UI

### Cycle 4+ — The umbrella / launcher

- Live-status pings per app; launch cards for `<name>.shiner.app`
- Migrate deployed apps from current hosts onto `shiner.app` subdomains
- GitHub live signals ~~; per-project detail pages~~ (detail pages shipped early, 2026-09-11)

## Open questions

Decide before Cycle 1 starts:
- [x] ~~**Account profile**~~ — **resolved 2026-09-11: `personal`.** `momir.shiner.app` is already
      deployed on Cloudflare Pages under the personal profile, so `shiner.app` lives in the personal
      Cloudflare account. `project-init` takes the default profile; no business token needed.
- [x] ~~**Repo visibility**~~ — **resolved 2026-09-11: public** (`github.com/raymondshiner/projects-browser`).
- [x] ~~**Client-work consent**~~ — **resolved 2026-09-11: moot — no actual client work exists yet.**
      All currently built projects seed in. **Standing rule:** every new build gets added by default;
      builds under the `business` profile → ask Raymond per-project (some will go in, some won't).
- [x] ~~**Screenshot pipeline**~~ — **resolved 2026-09-11: Playwright-automated**
      (`scripts/capture-screenshots.mjs` → Supabase Storage `screenshots` bucket).
- [ ] **Does `rshiner-website-v3` eventually consume this**, or keep its own hand-written case studies
      as the narrative layer? (Leaning: keep both — index here, story there.)

## Risks / unknowns

- ~~**Runtime-fetch vs SEO.**~~ **Resolved 2026-09-11 — static prerender + deploy hook.** The
  deciding factor was not Googlebot (which does render JS, slowly) but **social crawlers: LinkedIn,
  Slack, Discord, X and Facebook execute no JavaScript at all.** A client-side fetch would make every
  link shared into a job application or LinkedIn post render as an empty preview card — worse than any
  ranking hit. Static HTML fixes it outright. Residual risk: a ~1-2 min lag between adding a row and
  it going live, which is irrelevant for data that changes a few times a month.
- **Deploy-hook reliability.** The "no rebuild" promise now depends on a Supabase webhook actually
  firing. If it silently fails, the site goes stale with no signal. Needs a visible last-built
  timestamp and a manual re-deploy escape hatch.
- **Two audiences, one domain.** Personal hobby projects next to paid client work can weaken the
  professional read. The category flag exists from day one so the split is cheap later.
- **Third portfolio surface.** This is the third place projects are described. If the syndication in
  Cycle 3 never lands, it becomes *more* maintenance, not less — Cycle 3 is the payoff, not a nice-to-have.
- **Supabase free tier** pauses idle projects. Low-traffic site + paused DB = a broken front door.
  Needs a keepalive or an edge cache that survives a cold DB.
- **Scope gravity toward the launcher.** The umbrella vision is exciting and not the MVP. Cycle 1
  ships an index; subdomain migration waits.

---
*Created 2026-09-11. Private ops log: `~/jarvis/claude/project-logs/projects-browser/log.md`*
