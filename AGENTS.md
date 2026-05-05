# AGENTS.md

Nix flake managing 3 hosts (NixOS + nix-darwin + home-manager).

## Hosts

| Host | Platform | System |
|---|---|---|
| `okabe-rintarou` | NixOS desktop | `x86_64-linux` |
| `kurisu-makise` | Personal MacBook | `aarch64-darwin` |
| `hiyajou-maho` | Work MacBook | `aarch64-darwin` |

## Directory layout

- `hosts/<name>/default.nix` — returns `{ name, nixos-modules?, darwin-modules?, home-modules? }`
- `modules/base/` — system modules shared by NixOS and darwin (auto-imported via `scanPaths`)
- `modules/nixos/` — NixOS-only system modules (auto-imported)
- `modules/darwin/` — macOS-only system modules (auto-imported)
- `home/base/` — home-manager modules shared by Linux and macOS
- `home/linux/` — Linux-only home modules
- `home/darwin/` — macOS-only home modules
- `home/specializations/` — opt-in feature flags (`lib.mkEnableOption` pattern)
- `vars/default.nix` — username, email, fullname

To add a module, just drop a `.nix` file in the right dir — `scanPaths` picks it up automatically.

## Commands

```
nix flake check          # validate all configs (also runs in CI)
nix flake update         # update all inputs

# rebuild a host (run on that machine, depending on os):
nh os switch .
nh darwin switch .
```

## Gotchas

- No `.gitignore`, no pre-commit hooks, no direnv, no task runner
- `packages/` contains custom derivations but they are **not** wired into flake outputs — they're only usable inline in module definitions
- Homebrew cleanup is aggressive: `cleanup = "uninstall"` removes undeclared casks/formulae on rebuild
- CI (GitHub Actions) runs `nix flake check` on PRs; Dependabot updates flake inputs weekly
- File modifications must be staged or committed in git to be visible in any `nix` command
