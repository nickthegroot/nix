{ pkgs, ... }:
let
  inherit (pkgs) stdenv;

  magick = "${pkgs.imagemagick}/bin/magick";

  usageCheck = ''
    if [ -z "$1" ]; then
      echo "Usage: clippimg <file_name>"
      exit 1
    fi
  '';

  isImageCheck = ''
    isImage() {
      case "$(od -An -N4 -tx1 < "$1" | tr -d ' \n')" in
        89504e47* | ffd8ff* | 47494638* | 424d* | 52494646*) return 0 ;;
        *) return 1 ;;
      esac
    }
  '';

  # Normalize the raw clipboard image to the target file's extension via ImageMagick.
  # A file name without an extension keeps the original bytes.
  normalize = ''
    ext="''${1##*.}"
    if [ "$ext" = "$1" ]; then
      mv "$tmp" "$1"
      chmod 644 "$1"
    else
      if ! ${magick} -list format | awk '{ print tolower($1) }' | tr -d '*+!' | grep -qx "''${ext,,}"; then
        echo "Unsupported image extension: .$ext" >&2
        exit 1
      fi
      ${magick} "$tmp" "$1"
    fi
  '';

  darwinSave = ''
    ${usageCheck}
    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT
    osascript -e 'on run argv
      set outputPath to item 1 of argv
      set pngData to the clipboard as «class PNGf»
      set fileRef to open for access outputPath with write permission
      write pngData to fileRef
      close access fileRef
    end run' "$tmp"
    ${normalize}
  '';

  linuxSave = ''
    ${usageCheck}
    ${isImageCheck}
    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT
    dms cl paste > "$tmp" || exit 1
    if ! isImage "$tmp"; then
      echo "No image in clipboard" >&2
      exit 1
    fi
    ${normalize}
  '';

  clippimg = pkgs.writeShellScriptBin "clippimg" (
    if stdenv.isDarwin then darwinSave else linuxSave
  );
in
{
  home.shellAliases = {
    "clipc" = if stdenv.isDarwin then "pbcopy" else "dms cl copy";
    "clipp" = if stdenv.isDarwin then "pbpaste" else "dms cl paste";
  };

  home.packages = [ clippimg ];
}