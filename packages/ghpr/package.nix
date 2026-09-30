{ writeShellScriptBin, gh }:
let
  ghBin = "${gh}/bin/gh";
in
writeShellScriptBin "ghpr" ''
  if [ -f "$1" ]; then
    exec ${ghBin} pr create --recover "$@"
  else
    exec ${ghBin} pr create "$@"
  fi
''
