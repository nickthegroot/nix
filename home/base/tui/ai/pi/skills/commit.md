---
name: commit
description: >
  Ultra-compressed commit message generator. Cuts noise from commit messages while preserving
  intent and reasoning. Scoped Commits format. Subject ≤50 chars, body only when explicitly
  requested.
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

**Body:**
- **Only write a body when the user explicitly asks for one.** Never generate it on your own initiative.

**Ticket number (optional):**
- In parentheses after scope: `auth (TICKET-123): fix login bug`
- Or in body/trailer: `TICKET-123`

**Multi-scope:**
- Use broader scope covering all touched areas
- Or comma-separate: `auth,storage: unify token handling`
- Tree-wide changes: `treewide`, `all`, or `global`

**Sign-off:**
- When code part or all AI-written: `Assisted-by: pi:MODEL_ID`
- AGENT_NAME is always `pi` — this skill ships with pi.
- **Look up the actual model at commit time — never guess or reuse a
  remembered value.** pi exports `PI_PROVIDER`, `PI_MODEL`, and
  `PI_SESSION_FILE` into the shell tool's environment for the active
  session. `PI_MODEL` is already the bare model id, so use it directly
  (`glm-5.3-flash`), lowercase, without the provider or thinking level.

**What NEVER goes in:**
- Type prefixes (`feat:`, `fix:`, `chore:`, etc.) — scope alone is sufficient
- "This commit does X", "I", "we", "now", "currently" — the diff says what
- "As requested by..." — use Co-authored-by trailer
- Emoji (unless project convention requires)
- Restating the file name when scope already says it

## Examples

Diff: new endpoint for user profile; body would explain the why, but user didn't ask for one
- ❌ "feat(api): add GET /users/:id/profile" (Conventional Commits)
- ❌ "api: add GET /users/:id/profile\n\nMobile client needs profile data without the full user payload…" (unprompted body)
- ✅ "api: add GET /users/:id/profile"

Diff: multi-package tweak
- ✅ "client,server: normalize error response format"

Diff: breaking API change, user explicitly asked for a body
- ✅
  ```
  api: rename /v1/orders to /v1/checkout

  BREAKING CHANGE: clients on /v1/orders must migrate to /v1/checkout
  before 2026-06-01. Old route returns 410 after that date.
  ```

Diff: same breaking change, user did NOT ask for a body
- ✅ "api: rename /v1/orders to /v1/checkout"
