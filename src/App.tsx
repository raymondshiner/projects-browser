import registry from '@/data/projects.json'
import type { Registry } from '@/types'
import { ProjectCard } from '@/components/ProjectCard'

const { built_at, projects } = registry as Registry

export default function App() {
  const shipped = projects.filter((p) => p.status === 'shipped').length
  const builtDate = new Date(built_at)

  return (
    <div className="mx-auto flex min-h-screen max-w-6xl flex-col px-5 py-10 sm:px-8">
      <header className="mb-10">
        <p className="mb-2 font-mono text-sm text-primary">shiner.app</p>
        <h1 className="font-mono text-3xl font-bold tracking-tight text-foreground sm:text-4xl">
          Things I&rsquo;ve built
        </h1>
        <p className="mt-3 max-w-2xl text-base leading-relaxed text-muted-foreground">
          The canonical registry of everything Raymond Shiner has shipped — apps, sites, and
          tools. {shipped} shipped, more underway. The story-length case studies live at{' '}
          <a href="https://raymondshiner.com" className="text-primary hover:underline">
            raymondshiner.com
          </a>
          .
        </p>
      </header>

      <main className="grid flex-1 grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
        {projects.map((project) => (
          <ProjectCard key={project.id} project={project} />
        ))}
      </main>

      <footer className="mt-12 flex flex-wrap items-center justify-between gap-2 border-t border-border pt-5 font-mono text-xs text-muted-foreground">
        <span>© {builtDate.getFullYear()} Raymond Shiner</span>
        <span>
          last built{' '}
          <time dateTime={built_at}>
            {builtDate.toISOString().slice(0, 16).replace('T', ' ')} UTC
          </time>
        </span>
      </footer>
    </div>
  )
}
