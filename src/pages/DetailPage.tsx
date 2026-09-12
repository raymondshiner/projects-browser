import Markdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import { ExternalLink, GitBranch, ArrowLeft } from 'lucide-react'
import type { Project } from '@/types'
import { Footer } from '@/components/Footer'

export function DetailPage({ project, built_at }: { project: Project; built_at: string }) {
  return (
    <div className="mx-auto flex min-h-screen max-w-3xl flex-col px-5 py-10 sm:px-8">
      <nav className="mb-8">
        <a
          href="/"
          className="inline-flex items-center gap-1.5 font-mono text-sm text-muted-foreground hover:text-primary"
        >
          <ArrowLeft className="size-4" aria-hidden="true" />
          all projects
        </a>
      </nav>

      <header className="mb-8">
        <p className="mb-2 font-mono text-sm text-primary">shiner.app</p>
        <h1 className="font-mono text-3xl font-bold tracking-tight text-foreground sm:text-4xl">
          {project.title}
        </h1>
        <p className="mt-3 text-base leading-relaxed text-muted-foreground">{project.blurb}</p>

        <div className="mt-4 flex flex-wrap items-center gap-4 font-mono text-sm">
          {project.live_url && (
            <a
              href={project.live_url}
              className="inline-flex items-center gap-1.5 text-primary hover:underline"
            >
              <ExternalLink className="size-4" aria-hidden="true" />
              live
            </a>
          )}
          {project.repo_url && (
            <a
              href={project.repo_url}
              className="inline-flex items-center gap-1.5 text-muted-foreground hover:text-foreground hover:underline"
            >
              <GitBranch className="size-4" aria-hidden="true" />
              source
            </a>
          )}
          {project.status === 'archived' && (
            <span className="rounded-full border border-border bg-muted px-2 py-0.5 text-[11px] leading-4 text-muted-foreground">
              retired
            </span>
          )}
        </div>

        <ul className="mt-4 flex flex-wrap gap-1.5" aria-label="Tech stack">
          {project.stack.map((tech) => (
            <li
              key={tech}
              className="rounded border border-border bg-secondary px-1.5 py-0.5 font-mono text-[11px] leading-4 text-secondary-foreground"
            >
              {tech}
            </li>
          ))}
        </ul>
      </header>

      {project.screenshot_url && (
        <img
          src={project.screenshot_url}
          alt={`Screenshot of ${project.title}`}
          className="mb-8 rounded-lg border border-border"
        />
      )}

      {project.details_md && (
        <main className="prose-andromeda">
          <Markdown remarkPlugins={[remarkGfm]}>{project.details_md}</Markdown>
        </main>
      )}

      <Footer built_at={built_at} />
    </div>
  )
}
