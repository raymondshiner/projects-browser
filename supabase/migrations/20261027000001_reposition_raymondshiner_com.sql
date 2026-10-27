-- raymondshiner.com repositioned 2026-10-27: senior engineer first, AI as one
-- honest section. Registry copy follows the site's updated case study.

update public.projects set blurb = $md$Personal site, third iteration — Andromeda-themed portfolio with MDX case studies and a built-in chat assistant.$md$ where slug = 'raymondshiner-com';

update public.projects set details_md = $md$## The brief

Build a portfolio that doesn't just *show* work — *embodies* it. The site should show how I actually build things — including, honestly, how AI fits into it: the kind of thing that's hard to fake, and the kind of thing a recruiter or future collaborator can't get from a resume.

## Why v3 (and what was wrong with v2)

v1 was a 2021 React/CRA portfolio with particles and a typewriter. It aged.

v2 modernized the stack — React 19, Vite, Tailwind v4, shadcn — but it stopped at "default shadcn dashboard." Lots of clean cards, no personality. The site looked like every other engineer's portfolio that ran `npx shadcn add` and called it done.

v3 had to fix the *positioning* problem, not the *stack* problem.

## The approach

Three guardrails framed every decision:

1. **Cohere with the rest of my digital surface.** I'd already built a hand-tuned Hyprland desktop in the Andromeda palette — cyan accents, JetBrains Mono, brutalist edges. The site borrows that vocabulary directly.
2. **Make the AI use legible — and honest.** Most portfolios either hide the AI or make it the whole brand. Mine does neither: the homepage's "How I work" section spells out what I delegate, what stays human, and how output earns trust. The deeper tooling story lives in the site's case study.
3. **Ship the experience, not just the page.** The "Ask Raymond" chat is the differentiator — a clearly-labeled assistant that lets visitors interrogate my background in their own words, instead of clicking through bullet lists. It's also a live sample of the discipline: scoped to sourced facts, honest when it doesn't know.

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
- The agent configs stay in a private repo. Email if you want a walkthrough.$md$ where slug = 'raymondshiner-com';
