---
name: commit
description: >
  Ultra-compressed commit message generator. Cuts noise from commit messages while preserving
  intent and reasoning. Scoped Commits format. Subject ≤50 chars, body only when "why"
  isn't obvious.
---

Write commit messages terse and exact, then commit. Scoped Commits format. No fluff. Why over what.

## Rules

**Subject line:**
- `<scope>: <imperative summary>`
- `scope` — the subsystem, area, or module the commit touches; always required
- Imperative mood: "add", "fix", "remove" — not "added", "adds", "adding"
- ≤50 chars when possible, hard cap 72
- No trailing period
- No type prefix (no `feat`, `fix`, `chore`, etc.)

**Body (only if needed):**
- Skip entirely when subject is self-explanatory
- Add body only for: non-obvious *why*, breaking changes, migration notes, linked issues
- Wrap at 72 chars
- Bullets `-` not `*`
- Reference issues/PRs at end: `Closes #42`, `Refs #17`

**Ticket number (optional):**
- In parentheses after scope: `auth (TICKET-123): fix login bug`
- Or in body/trailer: `TICKET-123`

**Multi-scope:**
- Use broader scope covering all touched areas
- Or comma-separate: `auth,storage: unify token handling`
- Tree-wide changes: `treewide`, `all`, or `global`

**Sign-off:**
- When code part or all AI-written: `Assisted-by: AGENT_NAME:MODEL_VERSION`
- AGENT_NAME: name of the AI tool or framework (e.g. `opencode`)
- MODEL_VERSION: specific model version used (e.g. `claude-3-opus`)

**What NEVER goes in:**
- Type prefixes (`feat:`, `fix:`, `chore:`, etc.) — scope alone is sufficient
- "This commit does X", "I", "we", "now", "currently" — the diff says what
- "As requested by..." — use Co-authored-by trailer
- Emoji (unless project convention requires)
- Restating the file name when scope already says it

## Examples

Diff: new endpoint for user profile with body explaining the why
- ❌ "feat(api): add GET /users/:id/profile" (Conventional Commits)
- ✅
  ```
  api: add GET /users/:id/profile

  Mobile client needs profile data without the full user payload
  to reduce LTE bandwidth on cold-launch screens.

  Closes #128
  ```

Diff: multi-package tweak
- ✅ "client,server: normalize error response format"

Diff: breaking API change
- ✅
  ```
  api: rename /v1/orders to /v1/checkout

  BREAKING CHANGE: clients on /v1/orders must migrate to /v1/checkout
  before 2026-06-01. Old route returns 410 after that date.
  ```

## Auto-Clarity

Always include body for: breaking changes, security fixes, data migrations, anything reverting a prior commit. Never compress these into subject-only — future debuggers need the context.
