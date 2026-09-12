-- Private repos must not be linked publicly (visitors would 404)
update public.projects set repo_url = null
where slug in ('cmfc-spokane', 'app-factory-template', 'shiner-software');

insert into public.projects (slug, title, blurb, tags, stack, live_url, repo_url, category, status, sort, kind, details_md) values

('rshiner-website-v2', 'raymondshiner.com v2',
 'Second portfolio — the React 19 + Vite + Tailwind modernization. Superseded by v3.',
 '{portfolio,web,retired}', '{React 19,TypeScript,Vite,Tailwind v4,shadcn/ui}',
 null, 'https://github.com/raymondshiner/rshiner-website-v2',
 'personal', 'archived', 130, 'site',
 $md$## The brief

v1 had aged — class components, particles, a typewriter effect. v2 was the stack modernization: React 19, Vite, TypeScript, Tailwind v4, shadcn/ui.

## What it taught

It fixed the stack problem and exposed the positioning problem: clean cards, no personality — indistinguishable from every other portfolio that ran `npx shadcn add` and called it done. That lesson is the reason [v3](/p/raymondshiner-com/) leads with the Andromeda palette and the AI-native workflow instead of the component library.$md$),

('rshiner-website-v1', 'raymondshiner.com v1',
 'First portfolio (2021) — React class-era, particles, and a typewriter effect. Where it started.',
 '{portfolio,web,retired}', '{React,JavaScript}',
 null, 'https://github.com/raymondshiner/rshiner-website-v1',
 'personal', 'archived', 140, 'site',
 $md$## The brief

The first portfolio, built in 2021: React, animated particles, a typewriter headline — the era's house style, faithfully executed.

## What it taught

It shipped, which is the only thing a first portfolio has to do. Everything since has been iterating on what "show your work" actually means — v2 modernized the stack, [v3](/p/raymondshiner-com/) fixed the positioning.$md$),

('rshiner-blog', 'rshiner-blog',
 'A simple personal blog — an early standalone TypeScript/React build. Retired.',
 '{blog,web,retired}', '{React,TypeScript}',
 null, 'https://github.com/raymondshiner/rshiner-blog',
 'personal', 'archived', 150, 'site',
 $md$## The brief

A simple personal blog, built as a standalone TypeScript/React project in 2023.

## What it taught

Long-form writing wanted a home closer to the portfolio itself — the blog retired, and its job moved into the main site's content pages.$md$);
