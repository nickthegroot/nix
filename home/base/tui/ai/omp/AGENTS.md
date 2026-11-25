# Code Style

- Prioritize code correctness and clarity. Speed and efficiency are secondary priorities unless otherwise specified.
- Focus on writing self-explanatory code with meaningful variable and function names
    - Complex functions should be broken down into smaller, more manageable pieces to enhance readability and maintainability
- Use full words for variable names (no abbreviations like "q" for "queue")
- Write no comments. Zero is the expected outcome; a comment is a defect you justify, never a courtesy you extend.
    - First move the fact into an identifier, a type, a schema, an invariant/assertion, or a cited URL. Mechanism beats prose: if dropping the comment would let a wrong action through, what is missing is a mechanism, not a comment.
    - Keep one only if you can complete this sentence with a specific reader action: "Without this, <reader> will <do X>, breaking <Y>." "It's not obvious", "they might wonder", "upstream differs", and "it documents provenance" MUST NOT be used to complete it. If <X> already fails loudly — type error, failed test, schema rejection, invariant throw — the sentence fails and the comment MUST be deleted.
- Make heavy usage of types and interfaces to ensure type safety and make assumptions explicit
    - All inputs and outputs of functions must be typed, even in type-optional languages

# Organization & Architecture

- Decompose by volatility, never by function or domain. Group what changes together; separate what changes for different reasons.
    - Each axis of change — a volatility — is its own component behind a stable interface; a component MUST encapsulate exactly one volatility
    - The more volatile a thing, the more strictly it MUST be encapsulated. Volatility MUST NOT leak across an interface
- Design the contract before the implementation. An interface is a stable contract; implementations are volatile and MAY vary independently.
    - Interfaces MUST obey the Liskov Substitution Principle: any implementation MUST be usable wherever the contract is expected
    - Consumers MUST depend only on the contract, never on a concrete implementation
- Keep interaction out of the design. How components call each other is not a design concern; coupling to call order, transport, or orchestration is a defect.

# Testing

- Test behavior at the contract and system level, not the implementation. Unit tests only lock-in volatile implementation details and prove nothing.
- Prefer few tests that exercise an interface end to end over many tests of isolated internals
- Unit tests SHOULD be written during development to check that an implementation behaves as expected, but they MUST NOT be committed. Delete them once the implementation is verified — the committed suite is contracts and system-level tests only.
    - Development unit tests MUST test both the expected POSITIVE and NEGATIVE cases. For example: `assert(1 + 1 = 2)` AND `assert(1 + 1 != 3)`.

# User Impersoniation

You MUST NOT act as the user. All actions taken on the user's behalf MUST be formally approved by the user before running. Actions include:

- Posting a message in Slack
- Adding or responding to a PR comment
- Submitting a PR (in draft OR ready)

# Tool Calling

Use tools in the following order:

1. Native tool calls (e.g. `read`, `write`, `grep`)
2. Modern CLI tools:
    - `jq` for querying/formatting JSON, `yq` for YAML/TOML
    - `gh` — GitHub CLI (PRs, issues, releases)
    - `uv` / `uvx` — Python package/runner (fast)
    - `pnpm` - Node package manager (fast)
    - `nh`, `nix`, `nix-shell` — Nix tooling
3. Classic POSIX tooling:
    - `curl`
    - `cat`

# Search Scope and Command Hygiene

You MUST NOT search broad roots (`$HOME`, `/`, etc.). Limit searches to the repo or directory you are working in; if that returns nothing, the next step is a narrower root, not a wider one.

- Exclude dependency and cache trees: `.venv`, `node_modules`, `.git`, `.next`, `dist`, `build`, `target`, `result`, `.cache`, `Library`, `/nix/store`
- Bound the work: `fd --max-depth N`, `rg --max-filesize`, and `| head` when you only need examples.
- When several independent lookups are needed, run them as separate scoped commands instead of stacking many broad searches into one call.
