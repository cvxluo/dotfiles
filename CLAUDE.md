# Personal Development Preferences

## Version Control (jj/Jujutsu)

### General Workflow
- Commit work often using `jj commit` (not `jj describe` + `jj new`)
- Clean up history afterwards with `jj squash` or `jj absorb`
- Never push unless explicitly asked
- Ask before creating bookmarks

### Commit Messages
- Use conventional commit format: `type(scope): description`
- Types: `feat`, `fix`, `chore`, `refactor`, `test`, `docs`, `style`, `perf`
- Scope should describe the area of the codebase affected

### Co-authorship
Always add co-author trailer to commits:
```
Co-authored-by: Claude <noreply@anthropic.com>
```

Use multi-message format with jj:
```bash
jj commit -m "feat(scope): description" -m "" -m "Co-authored-by: Claude <noreply@anthropic.com>"
```

### Commit Granularity
- Be judicious - optimize for ease of review
- Keep commits logically separated so reviewers can understand changes incrementally
- Related changes can be grouped if they're tightly coupled
- Use `jj split` if a commit becomes too large or unfocused

### History Cleanup
- Use `jj squash` to combine related commits before review
- Use `jj absorb` to automatically fold fixups into the right commits
- Goal: clean, well-organized history that tells a clear story
