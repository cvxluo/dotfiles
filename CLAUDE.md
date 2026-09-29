
# Personal Development Preferences

## Version Control (jj/Jujutsu)

### General Workflow

The goal is to be able to run multiple agent sessions against a shared working copy.

**The "mega-merge" pattern:** a merge commit (`@`) on top of every in-flight feature branch, each branched off `trunk()`

```
        ┌── change-a - change-a-2 - change-a-3 ──┐
trunk ──┼── change-b ------------------------- ──┼── @  (mega = octopus merge)
        └── change-c ── change-c-2 ----------- ──┘
```

In the above example, we're working on 3 features, a, b, and c. The features are stacked into several changes - and the mega merge is the theoretical final state once all three changes are merged to trunk.

Some common patterns and operations:
- As a guiding principle, you can use your judgement on whether an operation is safe to run if it would break other concurrent sessions working on **different** features.
    - For example, if you `jj edit` to modify a specific change, that will always break other concurrent sessions that were editing other files in the mega merge - never do this.
    - However, if you `jj rebase` out a change out from the mega merge in order to edit a child change that you're working on, that won't break other features, so it is safe to do.
- When starting a new set of changes, you can make edits immediately on the mega merge commit (`@`). Then, split out the changes as a parent of the mega merge with `jj split -d 'trunk()' <files> -m "feat(scope): …"`
    - Make sure to specify the files you want to split out.
    - `jj absorb <files>` is a useful pattern if you have edits that need to be squashed into several changes at once.
- Never push unless explicitly asked
- Ask before creating bookmarks
- Sometimes you'll run into a conflict or divergence. You should always try to address these before asking for review.
    - Conflicts are often caused by pre-commit pushing a new commit.
    - You can prevent these by running pre-commit hooks manually before pushing. Remember that `jj` will not run pre-commit hooks automatically.
    - If you see a conflict caused by this pattern, you can resolve it by abandoning or absorbing the pre-commit change and moving the bookmark back where you want it.
- You should avoid leaving changes in the mega merge commit. You should always split out the changes into parents of the mega merge when possible.
- You are ALWAYS capable of making your desired with native `jj` commands, and should never compromise based on the difficulty of executing the desired change. You should NEVER need to write scripts or temporary files to operate `jj`.

### Commit Messages
- Use conventional commit format: `type(scope): description`
- Types: `feat`, `fix`, `chore`, `ref` (refactor), `test`, `docs`
- Scope should describe the area of the codebase affected

### Co-authorship
Pass a co-author trailer as an extra `-m` on `jj describe`/`split`/`squash`:
```bash
jj describe feat-a -m "feat(scope): description" \
                   -m "Co-authored-by: YOUR-NAME-HERE <YOUR-EMAIL-HERE@example.com>"
```
For example, if you are Claude, you should use `Co-authored-by: Claude <claude@anthropic.com>`. If you are Codex, you should use `Co-authored-by: Codex <codex@openai.com>`.
