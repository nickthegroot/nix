# Code Style

- Focus on writing self-explanatory code with meaningful variable and function names
    - Complex functions should be broken down into smaller, more manageable pieces to enhance readability and maintainability
- Write no comments. Zero is the expected outcome; a comment is a defect you justify, never a courtesy you extend.
    - First move the fact into an identifier, a type, a schema, an invariant/assertion, or a cited URL. Mechanism beats prose: if dropping the comment would let a wrong action through, what is missing is a mechanism, not a comment.
    - Keep one only if you can complete this sentence with a specific reader action: "Without this, <reader> will <do X>, breaking <Y>." "It's not obvious", "they might wonder", "upstream differs", and "it documents provenance" MUST NOT be used to complete it. If <X> already fails loudly — type error, failed test, schema rejection, invariant throw — the sentence fails and the comment MUST be deleted.
- Make heavy usage of types and interfaces to ensure type safety and make assumptions explicit
    - All inputs and outputs of functions should always be typed

# Secrets

Never attempt to read a file that contains secrets. This includes:
- `.env`
- `.env.*`

# Python Notebooks

When asked to create a Python notebook, use `.py` format with `# %%` for cell delimiters.

# Modern CLI Tool Preferences

Prefer these over their classic/POSIX equivalents when running shell commands:

- `fd` instead of `find` for file lookups.
- `rg` (ripgrep) instead of `grep` for searching file contents.
    - Note flags differ: `rg` is already recursive; never pass `-r`/`--recursive` (= replace) and use `-g` for globs.
- `jq` for querying/formatting JSON.
- `yq` for querying/formatting YAML/XML/CSV/TOML
- `xh` (or `xhs`) instead of `curl` for ad-hoc HTTP requests when readability matters; use `curl` for scripting.
- `tldr <cmd>` for quick command examples instead of reading full `man` pages.

# Search Scope and Command Hygiene

Never search broad roots. A search that walks `$HOME`, `/`, or the whole machine can traverse dependency, cache, and system trees and time out. Search the repo or directory you are working in; if that returns nothing, the next step is a narrower root, not a wider one.

- Exclude dependency and cache trees: `.venv`, `node_modules`, `.git`, `.next`, `dist`, `build`, `target`, `result`, `.cache`, `Library`, `/nix/store`
- Bound the work: `fd --max-depth N`, `rg --max-filesize`, and `| head` when you only need examples.
- When several independent lookups are needed, run them as separate scoped commands instead of stacking many broad searches into one call.

# Other Available Tools Worth Using

- `gh` — GitHub CLI (PRs, issues, releases). Prefer over REST API calls for GitHub work.
- `uv` / `uvx` — Python package/runner (fast).
- `nh`, `nix`, `nix-shell` — Nix tooling.

## tmux

Use tmux to run long-lived background processes (dev servers, watchers, build daemons) and to manage sub-agents.

- Run background processes in a named detached session, not `nohup`/`&`: `tmux new-session -d -s <name> '<command> 2>&1 | tee /tmp/<name>.log'`. The session survives the tool call and can be attached to live.
- Inspect without attaching using `tmux capture-pane -pt <name>`; interact with `tmux attach -t <name>`.
- Kill it with `tmux kill-session -t <name>` once the process is no longer needed, and report the session name if leaving it running.
- Keep sub-agents in separate panes or sessions.
