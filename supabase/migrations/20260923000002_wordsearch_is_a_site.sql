-- Rule: anything deployed at a URL is a site. Tools are things you clone and run.
update public.projects set kind = 'site' where slug = 'wordsearch';

alter table public.projects
  add constraint kind_tool_has_no_live_url
  check (not (kind = 'tool' and live_url is not null));
