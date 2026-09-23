insert into public.projects (slug, title, blurb, tags, stack, live_url, repo_url, category, status, sort, kind, details_md) values

('wordsearch', 'Word Search Generator',
 'Print-ready word search puzzles from your own word list — type words, tune one difficulty dial, export a two-page PDF with the answer key. Deterministic from a seed, honest about words it can''t place.',
 '{puzzle,print,generator}', '{React 19,TypeScript,Vite,Tailwind v4,shadcn/ui,react-pdf,Vitest}',
 'https://wordsearch.shiner.app', 'https://github.com/raymondshiner/wordsearch',
 'personal', 'shipped', 25, 'tool',
 $md$## The brief

A word search generator: words in, print-ready puzzle out. Grid, word bank, and a separate answer key as a two-page PDF. Built as a portfolio piece — the placement engine is a real constraint-satisfaction problem, and the architecture is the argument.

## The engine is the showpiece

`src/engine/` is a standalone, dependency-free module — pure functions, no React imports, written test-first with Vitest before any UI existed.

- **Eight directions** with backwards/diagonal toggles, so difficulty is a real dial and not a label.
- **Deterministic from a seed.** All randomness flows through one seeded PRNG (mulberry32) — the same seed always reproduces the identical grid, which is what makes shareable links possible later. The determinism test is load-bearing.
- **Honest failure.** A word that can't be placed is surfaced to the user, never silently dropped. The generator runs bounded restart attempts and keeps the best result — it degrades, it doesn't hang.
- **Capacity as a warning, not a wall.** Overloading the grid gets you a heads-up and a best effort, with the casualties listed.

## One screen, one dial

Word input with validation (dedupe, length bounds, non-letters stripped), a 1–5 difficulty dial that derives grid size and direction set, and an advanced disclosure for anyone who wants the raw knobs. Live preview with an answer-key toggle.

PDF export uses `@react-pdf/renderer`, lazy-loaded so the 400 kB rendering engine never touches first paint — puzzle and word bank on page one, answer key on page two.

## Verification

Thirteen Vitest cases on the engine (placement read-back, overlap legality, determinism, the unplaceable-word path) plus an eighteen-check Playwright `verify-ui` run against desktop and iPhone viewports — including asserting that the PDF actually downloads.$md$);

update public.projects set features = '{
  "Eight-direction placement engine, written test-first",
  "Deterministic — same seed, same puzzle",
  "Unplaceable words reported, never dropped",
  "One difficulty dial + advanced disclosure",
  "Two-page PDF: puzzle + word bank, answer key",
  "Live preview with answer highlighting"
}' where slug = 'wordsearch';
