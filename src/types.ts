export type Project = {
  id: string
  slug: string
  title: string
  blurb: string
  tags: string[]
  stack: string[]
  live_url: string | null
  repo_url: string | null
  case_study_url: string | null
  screenshot_url: string | null
  category: 'personal' | 'professional'
  status: 'shipped' | 'in-progress' | 'planned' | 'archived'
  kind: 'site' | 'tool'
  details_md: string | null
  sort: number
  created_at: string
  updated_at: string
}

export type Registry = {
  built_at: string
  projects: Project[]
}
