---
name: pr
description: >
  Drafts a pull request and saves it as pr-{short-snake-case-description}.json using
  the schema accepted by `gh pr create --recover`, so the user can review and edit the
  title, body, and metadata before opening the PR. Never creates the PR directly.
---

# PR

Draft a pull request, write it to `pr-{short-snake-case-description}.json` (the **PR
file**), and hand it back for review. The user edits the file, then opens the PR with:

```
gh pr create --recover pr-{short-snake-case-description}.json [--base <base>] [--head <head>]
```

The file is the deliverable, not the PR. Never run `gh pr create` yourself.

## Process

**1. Gather context.** Read the real changes, never guess from the request:
- Current branch: `git branch --show-current`
- Base branch: `gh-merge-base` config for the branch if set, else the repo default
  (`gh repo view --json defaultBranchRef -q .defaultBranchRef.name`), else `main`.
- Ticket: parse from the branch name (e.g. `<user>/<team-prefix>-123-...` → `TEAM-123`)
  or commit messages (e.g. `fixes team-123 : ...`), uppercased.
- Commits: `git log --oneline <base>..HEAD`; diff: `git diff <base>...HEAD` and
  `git diff --stat <base>...HEAD`.

**2. Find the repo's PR template.** `--recover` loads no template itself, so locate it
and use it as the body. Prefer a `PULL_REQUEST_TEMPLATE/` directory over a
`pull_request_template.md` file, and `.github/` over the root over `docs/`. Match names
case-insensitively with `_`/`-` interchangeable. If the winning directory has multiple
`.md` files, ask which to use. Strip a leading YAML frontmatter block (`---` … `---`).

**3. Write the title** in the format used by existing PRs:

`[{TICKET-ID}] {AREA}: {SHORT DESCRIPTION}`

- `{AREA}` — capitalized feature or subsystem (`Payments`, `Checkout`). Omit it and its
  colon for repo-wide changes: `[TEAM-123] Switch to \`pnpm\``.
- `{SHORT DESCRIPTION}` — sentence case (`Payments: save initial record to the database`).
- No ticket found → drop the prefix: `{AREA}: {SHORT DESCRIPTION}`.

**4. Write the body.** Replace the template's description placeholder (e.g.
`[Leave a description]`) with a GitHub-flavored Markdown description of what the change
does and why, in plain human prose like existing PRs. Use a `> [!NOTE]` callout for
reviewer caveats (one or two at most), and leave `![alt](url)` placeholders for
screenshots since images cannot be generated here.

Keep the rest of the template verbatim — any boilerplate appended after the description
(separators, tables, checklists) stays exactly and goes last. Never invent section headers
(`## Summary`, `## Changes`, etc.) and never drop template content. A small,
self-explanatory change may need only a sentence or an image placeholder. If no template
exists, write the same style of prose without added headings.

**5. Write the PR file.** Name it `pr-{short-snake-case-description}.json` at the repo
root, using a short snake-case summary of the change (e.g. `pr-add-oauth-login.json`).
The schema must match what `gh pr create --recover` unmarshals — exported Go field names,
capitalized:

```json
{
  "Title": "<title>",
  "Body": "<markdown body; escape newlines as \n>",
  "Draft": false,
  "Template": "",
  "Reviewers": [],
  "Assignees": [],
  "Labels": [],
  "ProjectTitles": [],
  "Milestones": []
}
```

Only populate `Reviewers`, `Assignees`, `Labels`, `ProjectTitles`, or `Milestones` when
the user asked or the repo clearly requires them.

**6. Hand off for review.** Tell the user the path, that they should edit it first, and
the exact command above. Include `--base`/`--head` when they differ from repo defaults;
`--recover` restores only title/body/metadata, not branches. Do not create the PR.

## Rules

- Ground the title and body in the real diff and commit history.
- Preserve PR template boilerplate byte-for-byte.
- Do not include reviewers, assignees, or labels the user did not request.
