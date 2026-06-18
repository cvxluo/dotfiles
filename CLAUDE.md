
# Personal Development Preferences

## Version Control (jj/Jujutsu)

### General Workflow

Optimized for running multiple Claude Code sessions against a shared working copy (no worktrees).

**The "mega-merge" pattern:** a merge commit (`@`) on top of every in-flight feature branch, each branched off `trunk()`. It's your integrated working view; each branch stays independently mergeable. All native jj.

```
        ┌── feat-a ──┐
trunk ──┼── feat-b ──┼── @  (mega = octopus merge)
        └── feat-c ──┘
```

1. **Build**: `jj new feat-a feat-b -m mega`.
2. **Route edits down**: edit in `@`, then `jj absorb` (routes each change to the branch owning those lines) or `jj squash --into feat-x -u <files>` (`-u` keeps that branch's message).
3. **Add a branch**: `jj split -d 'trunk()' <files> -m "feat(scope): …"` (peels onto a new branch, detaching from `@`), then `jj rebase -r @ -d feat-a -d feat-b -d feat-c` to re-merge.
4. **Drop a landed branch**: `jj git fetch`, then `jj rebase -r @ -d 'trunk()' -d <remaining>` and `jj bookmark delete <landed>`.

Branches can stay anonymous (by change-id); the push template names the bookmark, so create one only at push.

**Constraints:**

- **Reshape while stable**: jj snapshots `@` on every command, so route down and rebase when edits are settled; pause concurrent edits while reshaping
- **Same-file races**: jj protects history, not the working copy; last write wins on disk, so keep parallel sessions on disjoint paths
- Send each edit to the branch it belongs to
- Never push unless explicitly asked
- Ask before creating bookmarks

### Commit Messages
- Use conventional commit format: `type(scope): description`
- Types: `feat`, `fix`, `chore`, `ref` (refactor), `test`, `docs`
- Scope should describe the area of the codebase affected

### Co-authorship
jj adds no trailer; pass one as an extra `-m` on `jj describe`/`split`/`squash`:
```bash
jj describe feat-a -m "feat(scope): description" \
                   -m "Co-authored-by: Claude <noreply@anthropic.com>"
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

### Handling Divergences and Conflicts
- Conflicts are often caused by pre-commit pushing a new commit
- You can prevent these by running pre-commit hooks manually before pushing. Remember that `jj` will not run pre-commit hooks automatically.
- If you see a conflict caused by this pattern, you can resolve it by abandoning or absorbing the pre-commit change and moving the bookmark back where you want it.