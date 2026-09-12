import type { Project } from '@/types'

const statusStyle: Record<Project['status'], { label: string; className: string }> = {
  shipped: { label: 'shipped', className: 'bg-[#a8ff60]/10 text-[#a8ff60] border-[#a8ff60]/30' },
  'in-progress': { label: 'in progress', className: 'bg-[#ffe66d]/10 text-[#ffe66d] border-[#ffe66d]/30' },
  planned: { label: 'planned', className: 'bg-muted text-muted-foreground border-border' },
  archived: { label: 'archived', className: 'bg-muted text-muted-foreground border-border' },
}

export function ProjectCard({ project }: { project: Project }) {
  const status = statusStyle[project.status]
  const domain = project.live_url ? new URL(project.live_url).hostname : null

  return (
    <article className="group flex flex-col overflow-hidden rounded-lg border border-border bg-card transition-colors hover:border-primary/40">
      {project.screenshot_url && (
        <a
          href={project.live_url ?? project.repo_url ?? undefined}
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
        <div className="flex items-start justify-between gap-3">
          <h2 className="font-mono text-base font-semibold text-foreground">
            {project.live_url ? (
              <a
                href={project.live_url}
                className="hover:text-primary focus-visible:text-primary"
              >
                {project.title}
              </a>
            ) : (
              project.title
            )}
          </h2>
          <span
            className={`shrink-0 rounded-full border px-2 py-0.5 font-mono text-[11px] leading-4 ${status.className}`}
          >
            {status.label}
          </span>
        </div>

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
            <a href={project.live_url} className="text-primary hover:underline">
              {domain} ↗
            </a>
          )}
          {project.repo_url && (
            <a href={project.repo_url} className="text-muted-foreground hover:text-foreground hover:underline">
              source ↗
            </a>
          )}
          {project.case_study_url && (
            <a href={project.case_study_url} className="text-accent hover:underline">
              case study ↗
            </a>
          )}
          {!project.live_url && !project.repo_url && !project.case_study_url && (
            <span className="text-muted-foreground">no public links yet</span>
          )}
        </div>
      </div>
    </article>
  )
}
