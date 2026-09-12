import { useState } from 'react'
import type { Project } from '@/types'
import { ProjectCard } from '@/components/ProjectCard'
import { Footer } from '@/components/Footer'

const TABS = [
  { id: 'all', label: 'All' },
  { id: 'site', label: 'Sites' },
  { id: 'tool', label: 'Tools' },
] as const

type Tab = (typeof TABS)[number]['id']

export function IndexPage({ projects, built_at }: { projects: Project[]; built_at: string }) {
  const [tab, setTab] = useState<Tab>('all')

  return (
    <div className="mx-auto flex min-h-screen max-w-6xl flex-col px-5 py-10 sm:px-8">
      <header className="mb-8">
        <p className="mb-2 font-mono text-sm text-primary">shiner.app</p>
        <h1 className="font-mono text-3xl font-bold tracking-tight text-foreground sm:text-4xl">
          Things I&rsquo;ve built
        </h1>
        <p className="mt-3 max-w-2xl text-base leading-relaxed text-muted-foreground">
          The canonical registry of everything Raymond Shiner has shipped — sites, apps, and tools,
          each with the story of how it was built.
        </p>
      </header>

      <div role="tablist" aria-label="Filter projects" className="mb-6 flex gap-1 border-b border-border">
        {TABS.map((t) => (
          <button
            key={t.id}
            role="tab"
            aria-selected={tab === t.id}
            onClick={() => setTab(t.id)}
            className={`-mb-px cursor-pointer border-b-2 px-4 py-2 font-mono text-sm transition-colors ${
              tab === t.id
                ? 'border-primary text-primary'
                : 'border-transparent text-muted-foreground hover:text-foreground'
            }`}
          >
            {t.label}
          </button>
        ))}
      </div>

      <main className="grid flex-1 auto-rows-min grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
        {projects.map((project) => (
          <div key={project.id} hidden={tab !== 'all' && project.kind !== tab}>
            <ProjectCard project={project} />
          </div>
        ))}
      </main>

      <Footer built_at={built_at} />
    </div>
  )
}
