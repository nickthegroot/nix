## Code Style

- Focus on writing self-explanatory code with meaningful variable and function names
    - Complex functions should be broken down into smaller, more manageable pieces to enhance readability and maintainability
- Use comments sparingly and only in situations where the code's intent cannot be made clear (e.g. using external services)
    - Before using comments, first try to isolate the unintuitive portion into its own function with a clear name
    - If comments are still required, make sure they are SHORT and SUCCINCT
    - NEVER write comments that merely restate what the identifier or code already says. If the name says it, do not comment.
- Make heavy usage of types and interfaces to ensure type safety and make assumptions explicit
    - All inputs and outputs of functions should always be typed

## Secrets

Never attempt to read a file that contains secrets. This includes:
- `.env`
- `.env.*`

## Python Notebooks

When asked to create a Python notebook, use `.py` format with `# %%` for cell delimiters.

## Modern CLI Tool Preferences

Prefer these over their classic/POSIX equivalents when running shell commands:

- `fd` instead of `find` for file lookups.
- `rg` (ripgrep) instead of `grep` for searching file contents.
- `jq` for querying/formatting JSON (also `yq` when present for YAML).
- `xh` (or `xhs`) instead of `curl` for ad-hoc HTTP requests when readability matters; use `curl` for scripting.
- `tldr <cmd>` for quick command examples instead of reading full `man` pages.

## Other Available Tools Worth Using

- `gh` — GitHub CLI (PRs, issues, releases). Prefer over REST API calls for GitHub work.
- `uv` / `uvx` — Python package/runner (fast).
- `nix`, `nix-shell`, `nh` — Nix tooling.
