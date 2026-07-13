{ writeShellScriptBin, gh }:
let
  ghBin = "${gh}/bin/gh";
in
writeShellScriptBin "ghav" ''
  branch=$(git rev-parse --abbrev-ref HEAD)
  output=$(${ghBin} workflow run --ref "$branch" "$@" 2>&1)
  printf '%s\n' "$output"

  url=$(printf '%s\n' "$output" | grep '^https://' | head -n1)

  if [ -n "$url" ]; then
    exec ${ghBin} enhance "$url"
  fi
''