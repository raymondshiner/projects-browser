alter table public.projects add column features text[] not null default '{}';

-- Stale-fact fixes
update public.projects set details_md = replace(details_md,
  'Cards render at 97% scale to survive printer margins, `@media print` strips everything but the card, and auto-print fires as soon as the image loads.',
  '`@media print` strips everything but the card and auto-print fires as soon as the image loads. Print scale defaults to 97% — sized so the printout slips into a sleeve behind a real card without binding — with a slider to dial it anywhere from 50–120%.')
where slug = 'momir-card-printer';

update public.projects set details_md = replace(details_md,
  '- **Build:** Vite + TS strict, deployed to Vercel with an SPA rewrite and immutable asset caching in `vercel.json`',
  '- **Build:** Vite + TS strict, deployed to Cloudflare Pages at albhed.shiner.app (GitHub Actions builds and uploads on every push to main)')
where slug = 'al-bhed-translator';

update public.projects set features = '{
  "Roll by mana value, 1–16",
  "Card-image, text-card, and thermal-receipt print modes",
  "Print scale slider (50–120%), sleeve-ready 97% default",
  "Auto-print — roll lands, dialog opens",
  "Fullscreen play mode",
  "Dark mode + settings persisted locally"
}' where slug = 'momir-card-printer';

update public.projects set features = '{
  "Instant bidirectional translation — no translate button",
  "Learn mode with primer-style reveal animation",
  "Cipher reference card",
  "Searchable dictionary",
  "Shareable URL-hash links",
  "Mobile-first tab layout"
}' where slug = 'al-bhed-translator';

update public.projects set features = '{
  "“Ask Raymond” — AI chat over my background",
  "Living /now page",
  "MDX case studies",
  "Live GitHub activity chips",
  "Andromeda theme, matching the desktop",
  "Motion with reduced-motion respected everywhere"
}' where slug = 'raymondshiner-com';

update public.projects set features = '{
  "Fully static export — nothing to keep warm",
  "Contact form → Resend, verified end to end",
  "No accounts, no tracking",
  "Auto-deploy via GitHub Actions"
}' where slug = 'shinersolutions-com';

update public.projects set features = '{
  "Near-zero JavaScript",
  "Lighthouse 100 in all five categories",
  "WCAG 2.1 AA accessibility",
  "Local-SEO structured data",
  "Per-clinician and per-service pages",
  "Self-hosted Atkinson Hyperlegible for low-vision readability"
}' where slug = 'cmfc-spokane';

update public.projects set features = '{
  "To-scale Moonlander UI — every key clickable",
  "Tap / double-tap / hold editing per key",
  "Per-key RGB control",
  "Local QMK compile + flash, no cloud configurator",
  "Cross-references every hyprland.conf bind to its physical key",
  "Click opens, Escape closes"
}' where slug = 'moonkeys';

update public.projects set features = '{
  "Projects are Supabase rows — adding one is adding a row",
  "Every page prerendered to static HTML",
  "Self-republishing via database webhook → deploy hook",
  "Automated Playwright screenshot pipeline",
  "Per-page Open Graph / social-card meta",
  "Case studies stored as markdown in the registry"
}' where slug = 'projects-browser';

update public.projects set features = '{
  "Multi-tenant RLS architecture from the first migration",
  "Stripe webhook → database subscription sync",
  "Scripted credential provisioning",
  "Automated definition-of-done gate",
  "PWA + Google SSO wired by default"
}' where slug = 'app-factory-template';

update public.projects set features = '{
  "Hand-rolled waybar — no stock modules",
  "Custom GTK popup for every interactive control",
  "Click opens, Escape closes — no hover surprises",
  "Color-coded health states with matching glow",
  "Andromeda palette edge to edge",
  "Hands-off two-repo dotfile sync"
}' where slug = 'montressor';

update public.projects set features = '{
  "React 19 + Vite + Tailwind v4 modernization",
  "shadcn/ui component system"
}' where slug = 'rshiner-website-v2';

update public.projects set features = '{
  "2021 React class-era build",
  "Particle background + typewriter hero"
}' where slug = 'rshiner-website-v1';
