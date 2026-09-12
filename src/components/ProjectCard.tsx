import { ExternalLink, GitBranch } from 'lucide-react'
import type { Project } from '@/types'

export function ProjectCard({ project }: { project: Project }) {
  const detailHref = `/p/${project.slug}/`

  return (
    <article className="group flex flex-col overflow-hidden rounded-lg border border-border bg-card transition-colors hover:border-primary/40">
      {project.screenshot_url && (
        <a
          href={detailHref}
          tabIndex={-1}
          aria-hidden="true"
          className="block aspect-[16/9] overflow-hidden border-b border-border bg-muted"
        >
          <img
            src={project.screenshot_url}
            alt=""
            loading="lazy"
            className="h-full w-full object-cover object-top transition-transform duration-300 group-hover:scale-[1.02]"
          />
        </a>
      )}

      <div className="flex flex-1 flex-col gap-3 p-5">
        <h2 className="font-mono text-base font-semibold text-foreground">
          <a href={detailHref} className="hover:text-primary focus-visible:text-primary">
            {project.title}
          </a>
        </h2>

        <p className="flex-1 text-sm leading-relaxed text-muted-foreground">{project.blurb}</p>

        <ul className="flex flex-wrap gap-1.5" aria-label={`${project.title} tech stack`}>
          {project.stack.map((tech) => (
            <li
              key={tech}
              className="rounded border border-border bg-secondary px-1.5 py-0.5 font-mono text-[11px] leading-4 text-secondary-foreground"
            >
              {tech}
            </li>
          ))}
        </ul>

        <div className="flex items-center gap-4 border-t border-border pt-3 font-mono text-xs">
          {project.live_url && (
            <a
              href={project.live_url}
              className="inline-flex items-center gap-1.5 text-primary hover:underline"
            >
              <ExternalLink className="size-3.5" aria-hidden="true" />
              live
            </a>
          )}
          {project.repo_url && (
            <a
              href={project.repo_url}
              className="inline-flex items-center gap-1.5 text-muted-foreground hover:text-foreground hover:underline"
            >
              <GitBranch className="size-3.5" aria-hidden="true" />
              source
            </a>
          )}
          {project.details_md && (
            <a href={detailHref} className="ml-auto text-accent hover:underline">
              details →
            </a>
          )}
        </div>
      </div>
    </article>
  )
}
