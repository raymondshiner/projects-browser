create table public.projects (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title text not null,
  blurb text not null default '',
  tags text[] not null default '{}',
  stack text[] not null default '{}',
  live_url text,
  repo_url text,
  case_study_url text,
  screenshot_url text,
  category text not null default 'personal' check (category in ('personal', 'professional')),
  status text not null default 'shipped' check (status in ('shipped', 'in-progress', 'planned', 'archived')),
  sort integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.projects enable row level security;

create policy "Public read" on public.projects
  for select using (true);

create policy "Authenticated write" on public.projects
  for all to authenticated using (true) with check (true);

insert into storage.buckets (id, name, public)
values ('screenshots', 'screenshots', true);

create policy "Authenticated upload screenshots" on storage.objects
  for insert to authenticated with check (bucket_id = 'screenshots');

create policy "Authenticated update screenshots" on storage.objects
  for update to authenticated using (bucket_id = 'screenshots');

create policy "Authenticated delete screenshots" on storage.objects
  for delete to authenticated using (bucket_id = 'screenshots');
