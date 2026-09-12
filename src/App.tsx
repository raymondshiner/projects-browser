import registry from '@/data/projects.json'
import type { Registry } from '@/types'
import { IndexPage } from '@/pages/IndexPage'
import { DetailPage } from '@/pages/DetailPage'

const { built_at, projects } = registry as Registry

export default function App({ path }: { path: string }) {
  const match = path.match(/^\/p\/([a-z0-9-]+)\/?$/)
  const project = match ? projects.find((p) => p.slug === match[1]) : undefined

  if (match && project) {
    return <DetailPage project={project} built_at={built_at} />
  }
  return <IndexPage projects={projects} built_at={built_at} />
}
