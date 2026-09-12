export function Footer({ built_at }: { built_at: string }) {
  const builtDate = new Date(built_at)
  return (
    <footer className="mt-12 flex flex-wrap items-center justify-between gap-2 border-t border-border pt-5 font-mono text-xs text-muted-foreground">
      <span>© {builtDate.getFullYear()} Raymond Shiner</span>
      <span>
        last built{' '}
        <time dateTime={built_at}>{builtDate.toISOString().slice(0, 16).replace('T', ' ')} UTC</time>
      </span>
    </footer>
  )
}
