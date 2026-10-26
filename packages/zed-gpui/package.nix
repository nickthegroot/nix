{
  pkgs,
  applyPatches,
  fetchFromGitHub,
}:

# Cap pins this fork because the rev carries f596cde (destination alpha on
# transparent windows: Porter-Duff OVER, not additive), which its window shell needs:
# https://github.com/CapSoftware/Cap/blob/cap-v0.6.1/apps/desktop-gpui/Cargo.toml#L30-L32
let
  cap = pkgs.callPackage ../cap-cli/common.nix { };

  inherit (cap) version capSrc platforms;

  patchesDir = "${capSrc}/apps/desktop-gpui/patches";
in
applyPatches {
  name = "zed-gpui-${version}";
  src = fetchFromGitHub {
    owner = "wingleeio";
    repo = "zed";
    rev = "5d1f83d9f27a19bec1fb241dc33b42238af9cf8d";
    hash = "sha256-n7keT156MOwKcSDZs7dGrv6DKtlco7+wC5xOLN5htzw=";
  };
  patches = [
    "${patchesDir}/zed-gpui.patch"
    "${patchesDir}/zed-windows.patch"
    "${patchesDir}/zed-linux.patch"
    "${patchesDir}/zed-idle-frames.patch"
  ];
}
// {
  meta = {
    description = "Zed's GPUI source tree patched for Cap";
    homepage = "https://github.com/wingleeio/zed";
    inherit platforms;
  };
}
