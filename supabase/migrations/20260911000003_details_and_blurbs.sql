alter table public.projects add column details_md text;
alter table public.projects add column kind text not null default 'site' check (kind in ('site', 'tool'));
update public.projects set kind = 'tool' where slug in ('moonkeys', 'app-factory-template');

update public.projects set blurb = $md$Roll a random Magic creature by mana value and print it as a proxy — Momir Basic for kitchen-table play.$md$ where slug = 'momir-card-printer';
update public.projects set blurb = $md$Bidirectional English ↔ Al Bhed cipher translator from Final Fantasy X, with a learn mode and searchable dictionary.$md$ where slug = 'al-bhed-translator';
update public.projects set blurb = $md$Personal site, third iteration — an AI-native portfolio with a built-in “Ask Raymond” chat.$md$ where slug = 'raymondshiner-com';
update public.projects set blurb = $md$Front door for Shiner Solutions — bespoke software for local mom-and-pop businesses.$md$ where slug = 'shinersolutions-com';
update public.projects set blurb = $md$Spec rebuild of a counseling practice’s website — static, near-zero-JS, Lighthouse 100 across the board.$md$ where slug = 'cmfc-spokane';
update public.projects set blurb = $md$Open-source homeschool tracker and planner: attendance, loop schedules, credit hours, and calendars.$md$ where slug = 'schoolhouse';
update public.projects set blurb = $md$Keyboard and hotkey customizer for Hyprland + the ZSA Moonlander, in one Moonlander-shaped popup.$md$ where slug = 'moonkeys';
update public.projects set blurb = $md$This site — the canonical registry of everything I’ve built, republished from a database row.$md$ where slug = 'projects-browser';
update public.projects set blurb = $md$A frozen, verified template for producing bespoke production apps: clone, configure, verify, deploy.$md$ where slug = 'app-factory-template';
update public.projects set blurb = $md$Installable PWA for AI-assisted yard and home redesign — photo in, structured plan out.$md$ where slug = 'spruce';
update public.projects set blurb = $md$Marketing site + client portal for Shiner Software’s managed-website plans.$md$ where slug = 'shiner-software';
update public.projects set blurb = $md$Unified personal media log for film, TV, games, books, and music — one self-owned app.$md$ where slug = 'almanac';

update public.projects set details_md = $md$## The brief

Final Fantasy X buries half its world in Al Bhed — a substitution cipher you decode one primer at a time. The web has translators, but they're old-internet: ad-stuffed, light-mode-only, broken on mobile, and none of them respect the *primer mechanic* that makes the language feel earned.

I wanted a translator that was fast, mobile-first, themed in the Andromeda palette I use everywhere else, and that could double as the proving ground for the stack I'd commit to for everything else this year.

## Why it mattered (beyond the toy)

This was the first project I built end-to-end with the Claude Code agent crew — Jarvis, Friday, Smith. Picking a small, well-scoped problem let me debug the *workflow* without the *product* fighting me.

By the time it shipped, I had:

- a validated stack default (Vite + React 19 + Tailwind v4 + shadcn/Radix Nova) that I now reach for on every new web project
- a `verify-ui` Playwright pattern that drives desktop + mobile viewports and asserts behavior, not pixels
- a documented set of shadcn-on-Tailwind-v4 gotchas — saving the next project a half-day of cascade debugging

The translator is the artifact. The workflow is the deliverable.

## The approach

- **Bidirectional translation, instant.** Type either side, the other updates as you go. No "translate" button.
- **Mobile-first tabs.** The shadcn `Tabs` primitive hard-codes a short height; I stripped its `group-data-horizontal/tabs:h-8` so the bar can be tall-with-icons on phones and compact on desktop.
- **Andromeda everywhere.** Same cyan accent, same JetBrains Mono, same muted slate as the desktop and this site. Cross-surface coherence is a feature.
- **SEO that ships.** OG image, sitemap.xml, robots.txt, and a JSON-LD `WebApplication` schema — verified in `dist/` before every deploy, not assumed.

## Architecture notes

- **Build:** Vite + TS strict, deployed to Vercel with an SPA rewrite and immutable asset caching in `vercel.json`
- **UI:** React 19 + shadcn/ui (Radix Nova preset), Tailwind v4 with `@theme inline` tokens promoted from Andromeda
- **Cipher:** pure functions, no framework — the translator is a 30-line module with a fixture file for round-trip tests
- **Verification:** `tests/verify-ui.mjs` boots Playwright against the production URL, runs through desktop + iPhone 13 viewports, asserts the semantic roles (input is `type="search"`, tabs are reachable by keyboard), and dumps screenshots to `/tmp/al-bhed-shots/`

## Gotchas worth remembering

- `:root` must precede `.dark` in `src/index.css`. shadcn's init script occasionally swaps them and the light theme silently wins on `<html class="dark">`.
- Drop `baseUrl` from `tsconfig.app.json` (deprecated in TS 6.0). Keep `paths` alone.
- shadcn's `tabsListVariants` ships with `h-8` hard-coded. Strip it and set responsive heights on the `TabsList` instance directly.

## What I'd do differently

Two things on the backlog:

1. **Native Android port** via Capacitor or Expo — share-sheet integration so you can pipe an Al Bhed string in from anywhere and read it inline. Offline-first.
2. **Primer mechanic** — toggle the FFX progression on, and only the letters you've "found" decode. Closer to the in-game experience than a flat lookup.

## See also

- [`raymondshiner/al-bhed-translator`](https://github.com/raymondshiner/al-bhed-translator) — source
- [albhed.raymondshiner.com](https://albhed.raymondshiner.com) — live$md$ where slug = 'al-bhed-translator';
update public.projects set details_md = $md$## The brief

Build a portfolio that doesn't just *show* work — *embodies* it. The site should make my AI-native workflow visible: the kind of thing that's hard to fake, and the kind of thing a recruiter or future collaborator can't get from a resume.

## Why v3 (and what was wrong with v2)

v1 was a 2021 React/CRA portfolio with particles and a typewriter. It aged.

v2 modernized the stack — React 19, Vite, Tailwind v4, shadcn — but it stopped at "default shadcn dashboard." Lots of clean cards, no personality. The site looked like every other engineer's portfolio that ran `npx shadcn add` and called it done.

v3 had to fix the *positioning* problem, not the *stack* problem.

## The approach

Three guardrails framed every decision:

1. **Cohere with the rest of my digital surface.** I'd already built a hand-tuned Hyprland desktop in the Andromeda palette — cyan accents, JetBrains Mono, brutalist edges. The site borrows that vocabulary directly.
2. **Make the AI workflow legible.** Most "AI-native engineer" portfolios just say the words. Mine carries a dedicated Workflow section that names the crew (Jarvis, Friday, Smith) and explains what each does. The desktop the crew runs on is public in [`montressor`](https://github.com/raymondshiner/montressor); the agent prompts and configs themselves stay private — that's the workshop, not the showroom.
3. **Ship the experience, not just the page.** The "Ask Raymond" chat is the differentiator — it lets visitors interrogate my background in their own words, instead of clicking through bullet lists.

## Architecture notes

- **Stack:** React 19 + Vite + Tailwind v4 + a thin shadcn-style component layer
- **Content:** MDX for case studies and the `/now` page, statically resolved through Vite
- **Animations:** Motion (formerly Framer Motion) with `useReducedMotion()` respected everywhere
- **Chat:** edge function calling Claude with my resume + projects cached as system context
- **Theme:** Andromeda tokens promoted to shadcn's semantic names so the components stay portable

## What I'd do differently

If the chat takes off, I'd add a feedback loop — let visitors thumbs-down answers and route those into a small eval set I can run before each deploy. Portfolio as product.

## See also

- [`raymondshiner/rshiner-website-v3`](https://github.com/raymondshiner/rshiner-website-v3) — source for this site
- [`raymondshiner/montressor`](https://github.com/raymondshiner/montressor) — the Andromeda desktop dotfiles this site borrows its vocabulary from
- The agent crew that ships it all stays in a private repo. Email if you want a walkthrough.$md$ where slug = 'raymondshiner-com';
update public.projects set details_md = $md$## The brief

Momir Basic is a Magic: The Gathering format where you pay X, discard a card, and get a *random* creature with mana value X. Playing it on paper means either a phone app held over the table or proxy sheets printed in advance. I wanted the middle path: roll at the table, print the creature on the spot, keep playing.

## How it was built

- **Scryfall as the only backend.** The random-creature roll is a single Scryfall search query (`is:firstprinting t:creature mv:X`) — no server, no database, no accounts. The whole app is static files.
- **Three print modes.** Full card image for color printers, an oracle-text-only card for ink-friendly proxies, and a thermal-receipt mode sized for 80mm receipt printers — because rolling a creature and having it *tick out of a receipt printer* at the kitchen table is the point.
- **Print CSS is the hard part.** Cards render at 97% scale to survive printer margins, `@media print` strips everything but the card, and auto-print fires as soon as the image loads.
- **Fullscreen play mode** keeps the roll UI on a phone or tablet propped at the table, styled in the same Andromeda palette as everything else I ship.

## Stack notes

Vite + React 19 + TypeScript strict, Tailwind v4, shadcn/ui (Radix Nova). Deployed to Cloudflare Pages via GitHub Actions — push to `main`, Actions builds and uploads. First project on the `shiner.app` umbrella domain.$md$ where slug = 'momir-card-printer';
update public.projects set details_md = $md$## The brief

Shiner Solutions needed a front door: a site that establishes credibility for bespoke software work and gets a local business owner to send a message. No accounts, no public pricing, no blog — a credibility-and-close brochure.

## How it was built

- **Static export, deliberately.** Next.js with `output: 'export'` — the whole site is prerendered HTML on Cloudflare Pages. There is nothing to keep warm, nothing to go down.
- **The contact form is the only moving part.** A Cloudflare Pages Function receives the POST and relays it through Resend. Verified end to end the day it shipped.
- **Deploys via GitHub Actions** — push to `main`, `wrangler pages deploy` uploads the export. A second manual workflow syncs the Resend API key into Pages secrets.

## Stack notes

Next.js (App Router, static export), React 19, TypeScript strict, Tailwind v4, shadcn/ui. Apex + www on Cloudflare, domain at Cloudflare Registrar.$md$ where slug = 'shinersolutions-com';
update public.projects set details_md = $md$## The brief

A seven-clinician counseling practice with an aging website. The rebuild had one job: be found — by locals searching, by AI answer engines, and by anyone on a slow phone — and be readable by everyone, including the accessibility tooling a counseling audience disproportionately relies on.

## How it was built

- **Astro, static, near-zero JS.** A brochure site has no business shipping a framework runtime. The output is HTML and CSS; the JS budget rounds to zero.
- **Local SEO as an architecture concern.** Structured data, per-clinician pages, service pages matching real query language, and a sitemap — built in from the start, not sprinkled on.
- **WCAG 2.1 AA throughout**, with self-hosted Alegreya + Atkinson Hyperlegible — the latter designed specifically for low-vision readability.
- **Lighthouse 100 in all five categories** — performance, accessibility, best practices, SEO, and PWA — verified on the deployed site, not localhost.

The deployed spec build carries a deliberate `noindex` so it never competes with the practice's live site before cutover.

## Stack notes

Astro + Tailwind v4 on Vercel. No client framework, no CMS — content lives in the repo.$md$ where slug = 'cmfc-spokane';
update public.projects set details_md = $md$## The brief

My wife homeschools our two kids, and Washington state wants records: attendance days, subject hours for high-school credit, and enough of a paper trail to survive an audit. Spreadsheets were working, barely. Schoolhouse replaces them with one app shaped exactly like our homeschool actually runs.

## How it was built

- **Loop schedules, not calendars.** Homeschool days don't map to fixed weekly timetables — subjects rotate through a loop at whatever pace the day allows. The data model treats the loop as first-class and derives the calendar view from it.
- **Supabase end to end.** Postgres with row-level security so each family sees only its own data, Google SSO for zero-password login, and the free tier carries a single-family workload comfortably.
- **Installable PWA** so it lives on the iPad home screen like a native app.
- **Mock mode** — the whole app runs against fixture data with no backend, which is what the Playwright verification suite drives in CI.

## Stack notes

Vite + React 19 + TypeScript, Tailwind v4, shadcn/ui, React Router 7, TanStack Query, react-hook-form + zod. The reference implementation for my Supabase + Google SSO + PWA defaults — later projects crib from it.$md$ where slug = 'schoolhouse';
update public.projects set details_md = $md$## The brief

My keyboard setup spans two config surfaces that don't know about each other: QMK firmware on a ZSA Moonlander (what each physical key *sends*) and Hyprland keybinds (what the desktop *does* with it). Changing a hotkey meant editing C firmware, flashing, then editing `hyprland.conf` — and hoping the two stayed in sync. Moonkeys puts both in one tool.

## How it was built

- **A Moonlander-shaped GTK popup.** The UI is a to-scale rendering of the physical board — every key clickable, showing its tap/double-tap/hold assignments and per-key RGB color.
- **Cross-referencing is the killer feature.** Every `bind` line in `hyprland.conf` is parsed and matched against the physical key that produces its keycode, so "what does this key actually do, end to end?" has one answer.
- **QMK, locally.** Edits generate QMK keymap constructs, compile with the local toolchain, and flash from the same popup. No Oryx, no cloud configurator — the keymap is code in a repo like everything else.
- Follows the same GTK3 + GtkLayerShell popup pattern as the rest of my desktop — PID-file click-toggle, Escape closes, Andromeda glow.

## Stack notes

Python 3, GTK3, GtkLayerShell, PyGObject; QMK toolchain for firmware builds. Bound to `SUPER+/` and used daily.$md$ where slug = 'moonkeys';
update public.projects set details_md = $md$## The brief

My projects were described in three places — the personal site, the business site, and reality — and every new ship meant hand-editing at least two of them. This site is the fix: one canonical registry, edited in one place, that republishes itself.

## How it was built

- **Projects are database rows.** A Supabase `projects` table (public-read RLS) holds every title, blurb, stack list, link, and the case study you're reading right now, as markdown in a column.
- **The site is static anyway.** At build time a script pulls the table, Vite builds the app, and every page — index and details — is server-rendered to plain HTML. Social crawlers (LinkedIn, Discord, Slack) execute no JavaScript, so static HTML is the difference between a rich preview card and a blank one.
- **The rebuild is a webhook.** A Supabase database webhook fires a Cloudflare Pages deploy hook on any row change. Add a row, and about a minute later the site has republished itself — no rebuild, no redeploy, no git push from me.
- **Screenshots are automated.** A Playwright script visits each live URL, captures it, uploads to Supabase Storage, and stamps the URL back onto the row.

## Stack notes

Vite + React 19 + TypeScript strict, Tailwind v4, shadcn/ui, react-markdown. Cloudflare Pages on the `shiner.app` umbrella — the front door for everything else that will live there.$md$ where slug = 'projects-browser';
update public.projects set details_md = $md$## The brief

After building the same production-app skeleton several times — auth, database with row-level security, billing, deploy pipeline, verification gate — I froze it into a template: clone, fill an intake JSON, flip feature flags, verify, deploy.

## How it was built

- **RLS architecture baked in.** Multi-tenant Postgres policies are the part most projects get wrong late; the template ships them wired from the first migration.
- **Stripe webhook sync** — subscription state flows from Stripe webhooks into the database, so the app never asks Stripe a question it can answer locally.
- **Credential provisioning scripted.** The setup scripts create and wire the Supabase project, secrets, and environment so a fresh clone reaches "running against real services" without manual dashboard work.
- **An automated definition-of-done gate.** Playwright end-to-end checks plus config verification must pass before the template calls a build shippable — the gate is part of the product.

## Stack notes

npm-workspaces monorepo: Vite + React 19 + TypeScript strict + Tailwind v4 + shadcn/ui + vite-plugin-pwa, Supabase (Postgres, RLS, Edge Functions, Google SSO), Stripe. Deliberately frozen — it moves only when a real project proves an improvement.$md$ where slug = 'app-factory-template';

insert into public.projects (slug, title, blurb, tags, stack, live_url, repo_url, category, status, sort, kind, details_md) values
('montressor', 'Montressor',
 $md$A hand-built Arch + Hyprland desktop — custom waybar, GTK popups, and one palette edge to edge.$md$,
 '{desktop,linux,dotfiles}', '{Hyprland,Python,GTK3,Waybar}',
 null, 'https://github.com/raymondshiner/montressor',
 'personal', 'shipped', 75, 'tool', $md$## The brief

Most Linux customizing stops at "configure things to look pretty." I wanted the opposite — a desktop where every visible piece was *built*, not just themed, and where the whole system spoke one visual language end to end.

Montressor is that desktop: an Arch + Hyprland workstation with a hand-rolled waybar, custom GTK popups for every interactive control, and the Andromeda palette running edge-to-edge — same cyan accent and JetBrains Mono I use on this site and the Al Bhed translator. The desktop dotfiles live in the public [`montressor`](https://github.com/raymondshiner/montressor) repo; the Claude Code agent crew that runs on top stays in a separate private repo. The crew is the secret sauce; it stays sealed.

## Why it mattered

I use my desktop and terminal eight hours a day. The cost of *not* shaping that environment compounds — every paper-cut I tolerated was one I'd tolerate forever. Stock waybar modules are fine until you want them to behave a specific way; once you do, they're a wall. So I went under it.

The result is a desktop I can read at a glance and operate by muscle memory, with zero third-party widgets I didn't write or fork myself.

## The approach

Three rules drove every decision:

1. **Hand-build, don't import.** Every interactive control — battery, network, audio, brightness, calendar — is a Python + GTK3 + GtkLayerShell script that follows one pattern. Once you know the pattern, a new popup takes 20 minutes.
2. **Click opens, Escape closes.** No hover-to-open, no auto-close on focus-out, no surprise dismissals when the cursor drifts. The desktop respects intent.
3. **One palette, one font, everywhere.** Andromeda cyan for active/connected, green for healthy, yellow for warning, red for critical/off. JetBrains Mono Nerd Font on every surface. Cross-surface coherence isn't decoration — it's how I read the system at a glance.

## Architecture notes

- **Waybar, two patterns.** Group/drawer modules for grouped status (connectivity → network → VPN; hardware → memory → CPU), and bespoke GTK popups for anything interactive. The bar itself is intentionally quiet — essentials always visible, secondary info one click away.
- **Hyprland as the substrate.** Custom keybinds drive workspace flow, scratchpads, and the popup launchers. Every bind is documented in `hyprland.conf`; nothing lives only in my head.
- **Color-coded health states.** Glow color on each popup matches the state of what it controls. A red audio popup means muted; cyan means active. The bar tells you the same thing the popup will, so opening it just adds detail.
- **GPU-aware.** Intel iGPU handles display, RTX 4060 dGPU runs intensive apps via `prime-run`. Never switch to dGPU-only mode — it breaks display output. The kind of footgun you learn exactly once.
- **Dotfiles synced hands-off.** A `dots` zsh function detects which repo `$PWD` is in (public dotfiles vs. private prompts) and commits + pushes that one. Neither repo sits dirty for long.

## The GTK popup pattern

Every popup follows the same skeleton: PID file for click-toggle, GtkLayerShell anchored to the right edge of the bar, RGBA visual so the rounded corners read clean, debounced slider writes via `GLib.timeout_add` to avoid flooding `pactl` or `sysfs`. The Andromeda glow color is templated into the CSS per-popup, so audio gets cyan, network-down gets red, and battery-charging gets cyan with a different icon.

The trap I hit early: `focus-out-event` seems like the obvious "close when the user clicks away" signal. It also fires when the cursor moves from the bar *toward* the popup, causing immediate dismissal. Solution: don't use it. Escape closes, clicking the bar icon toggles, and that's the contract.

Other lessons that cost me an hour each:

- `margin: 8px` is the glow's breathing room *outside* the rounded card; `padding: 16px` is the content space *inside*. Mix them up and the shadow gets clipped.
- CSS braces need to be doubled (`{{}}`) inside Python `.format()` strings or you'll spend twenty minutes wondering why the template silently ate them.
- Slider labels need `connect('format-value', ...)` — `set_format_value_func` is GTK4 only and silently no-ops on GTK3.

## Andromeda, the through-line

| Role | Hex |
|---|---|
| Background | `#1C1E26` / `#23262E` |
| Bright text | `#D5CED9` |
| Muted / inactive | `#8B97AF` |
| Cyan (active, charging, connected) | `#00E8C6` |
| Green (healthy) | `#A8FF60` |
| Yellow (warning) | `#FFE66D` |
| Red (critical / off) | `#EE5D43` |
| Purple accent | `#B084EB` |

These tokens drive the waybar CSS, the GTK popups, this portfolio, and the Al Bhed translator. New surfaces inherit the language automatically — there's no separate "web theme" or "desktop theme," just Andromeda.

## What I'd do differently

- **Document the popup pattern in the repo, not just in my head.** I built the second and third popups by copying the first, which works until the first one drifts. I now keep a canonical reference popup that other ones are linted against.
- **Bake the hyprland keybind map into a generated cheatsheet.** I have it in my head; nobody else does. A small script that reads `hyprland.conf` and emits a printable PDF would help when I switch machines.

## See also

- [`raymondshiner/montressor`](https://github.com/raymondshiner/montressor) — the public desktop dotfiles (Hyprland, waybar, kitty, popup scripts)
- The Claude Code agent crew that runs on top stays in a private repo. Want a guided tour? [raymondshiner@gmail.com](mailto:raymondshiner@gmail.com).$md$);
