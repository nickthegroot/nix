---
name: plan
description: >
  Investigates how to implement a described action or feature in the current codebase,
  explores viable approaches, and saves the decided plan to ./PLAN.md. The plan is
  written to be fully self-contained so a new developer or agent could execute it
  using only the plan and the files it references.
---

# Plan

Investigate the codebase, decide on an approach, and write a complete implementation
plan to `./PLAN.md`. The plan must be executable by someone with zero prior context.

## Process

**1. Understand the goal.** Restate the requested action in one or two sentences. If
the request is ambiguous, ask targeted questions before investigating — never guess
intent.

**2. Investigate.** Actually explore the codebase before planning. Do not plan from
assumptions:
- Identify the files, directories, and modules the change will touch — read them.
- Find existing patterns the implementation should follow (similar features, conventions, abstractions).
- Map dependencies: what the change relies on and what relies on it.
- Check build systems, test setup, and config relevant to the change.
- Note anything that makes the goal impossible or pointless; report back instead of planning a dead end.

**3. Explore approaches.** Identify at least two viable approaches when one exists.
For each, note the tradeoffs briefly. Pick one and state why in one sentence. If
there is genuinely only one sensible approach, say so.

**4. Confirm.** Present the chosen approach (and rejected alternatives) to the user
in a short summary. Save `PLAN.md` after presenting; do not block on approval unless
the change is destructive, large-scale, or the user asks to decide first.

**5. Write `./PLAN.md`.** Use the structure below. Every file or directory mentioned
must use a full path from the repo root (or absolute if outside the repo).

## PLAN.md Structure

```markdown
# Plan: <short title>

## Goal
<1–3 sentences. What will exist or work when this is done.>

## Current State
<How the relevant part of the codebase works today, with file paths.
Describe enough that a reader who has never seen the repo understands
the starting point.>

## Approach
<The chosen approach and a one-line reason. List rejected alternatives
with why they were rejected.>

## Relevant Files
<Table of every file/directory needed to execute the plan:>
| Path | Role in this change |
|---|---|
| path/to/file | <what it is and how it's involved> |

## Implementation Steps
<Ordered, concrete steps. Each step names exact files and describes the
change precisely enough to act without re-deriving decisions. Include
function/type/module names where relevant.>

## New Files
<Skeletons or precise descriptions for any new files, if applicable.>

## Verification
<How to prove it works: exact commands to run, what to observe,
edge cases to test.>

## Risks & Open Questions
<What could break, unclear requirements, decisions deferred to the
implementer.>
```

## Rules

- Ground everything in what you actually read — cite real paths, real names, real commands.
- If verification commands exist (tests, builds, type checks), use the project's real ones.
- No filler. Every section must contain information an implementer needs.
- Overwrite any existing `./PLAN.md`; do not append or version it.
- Keep the plan focused on this one goal; out-of-scope ideas go under Risks & Open Questions.