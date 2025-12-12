{ writeShellScriptBin, jq }:
let
  jqBin = "${jq}/bin/jq";
in
writeShellScriptBin "hypr-app-open" ''
  client="$1"
  launcher="$2"

  clients_json=$(hyprctl clients -j)
  current_id=$(hyprctl activewindow -j | ${jqBin} -r '.address')
  matching_windows=$(echo "$clients_json" | ${jqBin} --arg c "$client" '[.[] | select(.class == $c)]')
  count=$(echo "$matching_windows" | ${jqBin} -r 'length')

  if [ "$count" -eq 0 ]; then
    exec "$launcher" &
    exit
  fi

  current_win=$(echo "$clients_json" | ${jqBin} -r --arg id "$current_id" '.[] | select(.address == $id)')
  current_class=$(echo "$current_win" | ${jqBin} -r '.class // empty')

  if [ "$current_class" = "$client" ]; then
    # Exclude current window, pick most recent other
    target=$(echo "$matching_windows" | ${jqBin} -r --arg id "$current_id" '[.[] | select(.address != $id)] | sort_by(-.focusHistoryID) | .[0]')
  else
    # Pick most recent
    target=$(echo "$matching_windows" | ${jqBin} -r 'sort_by(-.focusHistoryID) | .[0]')
  fi

  target_addr=$(echo "$target" | ${jqBin} -r '.address // empty')

  if [ -n "$target_addr" ]; then
    hyprctl dispatch focuswindow address:"$target_addr"
  else
    exec "$launcher" &
  fi
''
