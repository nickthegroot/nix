# Code Style

- Focus on writing self-explanatory code with meaningful variable and function names
    - Complex functions should be broken down into smaller, more manageable pieces to enhance readability and maintainability
- Write no comments. Zero is the expected outcome; a comment is a defect you justify, never a courtesy you extend.
    - First move the fact into an identifier, a type, a schema, an invariant/assertion, or a cited URL. Mechanism beats prose: if dropping the comment would let a wrong action through, what is missing is a mechanism, not a comment.
    - Keep one only if you can complete this sentence with a specific reader action: "Without this, <reader> will <do X>, breaking <Y>." "It's not obvious", "they might wonder", "upstream differs", and "it documents provenance" MUST NOT be used to complete it. If <X> already fails loudly — type error, failed test, schema rejection, invariant throw — the sentence fails and the comment MUST be deleted.
- Make heavy usage of types and interfaces to ensure type safety and make assumptions explicit
    - All inputs and outputs of functions should always be typed
- Decompose by volatility, never by function or domain. Group what changes together; separate what changes for different reasons.
    - Each axis of change — a volatility — is its own component behind a stable interface; a component MUST encapsulate exactly one volatility.
    - The more volatile a thing, the more strictly it MUST be encapsulated. Volatility MUST NOT leak across an interface.
- Design the contract before the implementation. An interface is a stable contract; implementations are volatile and MAY vary independently.
    - Interfaces MUST obey the Liskov Substitution Principle: any implementation MUST be usable wherever the contract is expected.
    - Consumers MUST depend only on the contract, never on a concrete implementation.
- Keep interaction out of the design. How components call each other is not a design concern; coupling to call order, transport, or orchestration is a defect.

# Testing

- Test behavior at the contract and system level, not the implementation. Unit tests exercise volatile implementation details, so they lock in what should stay free to change and prove nothing about the requirements.
    - A green unit-test suite is not evidence of correctness; it only confirms the implementation agrees with itself.
    - Prefer few tests that exercise an interface end to end over many tests of isolated internals.
- Unit tests MAY be written during development to check that an implementation behaves as expected, but they MUST NOT be committed. Delete them once the implementation is verified — the committed suite is contracts and system-level tests only.

# Search Scope and Command Hygiene

Never search broad roots. A search that walks `$HOME`, `/`, or the whole machine can traverse dependency, cache, and system trees and time out. Search the repo or directory you are working in; if that returns nothing, the next step is a narrower root, not a wider one.

- Exclude dependency and cache trees: `.venv`, `node_modules`, `.git`, `.next`, `dist`, `build`, `target`, `result`, `.cache`, `Library`, `/nix/store`
- Bound the work: `fd --max-depth N`, `rg --max-filesize`, and `| head` when you only need examples.
- When several independent lookups are needed, run them as separate scoped commands instead of stacking many broad searches into one call.
