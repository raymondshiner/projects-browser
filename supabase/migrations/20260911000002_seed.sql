insert into public.projects (slug, title, blurb, tags, stack, live_url, repo_url, category, status, sort) values

('momir-card-printer', 'Momir Card Printer',
 'Roll a random Magic: The Gathering creature by mana value and print it as a proxy — Momir Basic for kitchen-table play. Card-image, oracle-text, and thermal-receipt print modes with a fullscreen play mode.',
 '{game,mtg,print}', '{React 19,TypeScript,Vite,Tailwind v4,shadcn/ui,Scryfall API}',
 'https://momir.shiner.app', 'https://github.com/raymondshiner/momir-card-printer',
 'personal', 'shipped', 10),

('al-bhed-translator', 'Al Bhed Translator',
 'Bidirectional English ↔ Al Bhed cipher translator from Final Fantasy X, with a learn-mode reveal animation, cipher reference card, searchable dictionary, and shareable links.',
 '{game,ffx,language}', '{React 19,TypeScript,Vite,Tailwind v4,shadcn/ui}',
 'https://albhed.shiner.app', 'https://github.com/raymondshiner/al-bhed-translator',
 'personal', 'shipped', 20),

('raymondshiner-com', 'raymondshiner.com',
 'Personal site, third iteration — an AI-native portfolio carrying the Andromeda desktop theme into the browser, with a living /now page, MDX case studies, an Anthropic-backed "Ask Raymond" chat, and live GitHub activity.',
 '{portfolio,web}', '{React 19,TypeScript,Vite,React Router 7,Tailwind v4,MDX,Anthropic SDK}',
 'https://raymondshiner.com', 'https://github.com/raymondshiner/rshiner-website-v3',
 'personal', 'shipped', 30),

('shinersolutions-com', 'shinersolutions.com',
 'Client-facing front door for Shiner Solutions — bespoke software for local mom-and-pop businesses. A credibility-and-close brochure site with a contact form wired end-to-end through Resend.',
 '{business,web}', '{Next.js,React 19,TypeScript,Tailwind v4,shadcn/ui,Cloudflare Pages,Resend}',
 'https://shinersolutions.com', 'https://github.com/raymondshiner/shinersolutions',
 'professional', 'shipped', 40),

('cmfc-spokane', 'CMFC Spokane Rebuild',
 'Spec rebuild of a 7-clinician counseling practice''s website — a static, near-zero-JS brochure site optimized for local SEO, AI answer engines, speed, and WCAG 2.1 AA. Lighthouse 100 across all five categories.',
 '{business,web,a11y}', '{Astro,Tailwind v4}',
 'https://cmfc-spokane.vercel.app', 'https://github.com/raymondshiner/cmfc-spokane',
 'professional', 'shipped', 50),

('schoolhouse', 'Schoolhouse',
 'Open-source homeschool tracker and planner: daily attendance, per-kid loop schedules, hours logging for high-school credit, planning calendars, field trips, and a reading log. Google SSO, installable PWA.',
 '{education,pwa}', '{React 19,TypeScript,Vite,Tailwind v4,shadcn/ui,Supabase,TanStack Query}',
 null, 'https://github.com/raymondshiner/schoolhouse',
 'personal', 'shipped', 60),

('moonkeys', 'Moonkeys',
 'One-stop keyboard and hotkey customizer for Hyprland + the ZSA Moonlander in a single Moonlander-shaped popup: edit tap/hold keys and per-key RGB, compile and flash QMK firmware, and cross-reference every WM bind against the physical key.',
 '{desktop,linux,firmware}', '{Python,GTK3,QMK}',
 null, 'https://github.com/raymondshiner/moonkeys',
 'personal', 'shipped', 70),

('projects-browser', 'browse.shiner.app',
 'This site — the canonical registry of everything I''ve built. Projects live in Supabase; a database webhook rebuilds the static site whenever a row changes, so adding a project is just adding a row.',
 '{portfolio,meta}', '{React 19,TypeScript,Vite,Tailwind v4,shadcn/ui,Supabase,Cloudflare Pages}',
 'https://browse.shiner.app', 'https://github.com/raymondshiner/projects-browser',
 'personal', 'shipped', 80),

('spruce', 'Spruce',
 'Installable PWA for AI-assisted yard and home redesign: photo in, opinionated structured plan out. BYOK — each user supplies their own model key, so operating cost stays at zero.',
 '{ai,pwa,home}', '{React 19,TypeScript,Vite,Tailwind v4,Zustand,Cloudflare Workers}',
 null, 'https://github.com/raymondshiner/spruce',
 'personal', 'in-progress', 90),

('app-factory-template', 'App Factory Template',
 'A frozen, verified template for producing bespoke production apps: clone, fill an intake JSON, flip flags, verify, deploy. Bakes in RLS architecture, Stripe webhook sync, and an automated definition-of-done gate.',
 '{template,infra}', '{React 19,TypeScript,Vite,Tailwind v4,Supabase,Stripe,Playwright}',
 null, 'https://github.com/raymondshiner/app-factory-template',
 'professional', 'shipped', 100),

('shiner-software', 'Shiner Software',
 'Marketing site + client portal for Shiner Software — managed websites for small businesses in Spokane Valley. Public pages plus a portal with billing, resources, and support requests.',
 '{business,web}', '{Next.js,React 19,TypeScript,Tailwind v4,shadcn/ui,Supabase,Stripe}',
 null, 'https://github.com/raymondshiner/shiner-software',
 'professional', 'in-progress', 110),

('almanac', 'Almanac',
 'Unified personal media log for film, TV, games, books, and music — one self-owned app replacing Letterboxd, Backloggd, Goodreads, and RYM.',
 '{media,self-hosted}', '{Next.js,React 19,TypeScript,Tailwind v4,Drizzle,SQLite}',
 null, 'https://github.com/raymondshiner/almanac',
 'personal', 'planned', 120);
