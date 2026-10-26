{
  lib,
  fetchFromGitHub,
  alsa-lib,
  dbus,
  fontconfig,
  freetype,
  libglvnd,
  libX11,
  libXcursor,
  libXext,
  libXfixes,
  libXrandr,
  libxcb,
  libxkbcommon,
  libva,
  vulkan-loader,
  openssl,
  pipewire,
  wayland,
}:

let
  version = "0.6.1";
in
{
  inherit version;

  capSrc = fetchFromGitHub {
    owner = "CapSoftware";
    repo = "Cap";
    tag = "cap-v${version}";
    hash = "sha256-aNfw33eEzdxojsBlgsLp01dtbhp72lGevyfauUx09ps=";
  };

  cidrePatch = ./cidre-pomace.patch;

  linuxBuildInputs = [
    alsa-lib
    dbus
    fontconfig
    freetype
    libglvnd
    libX11
    libXcursor
    libXext
    libXfixes
    libXrandr
    libxcb
    libxkbcommon
    libva
    vulkan-loader
    openssl
    pipewire
    wayland
  ];

  runtimeDependencies = [
    vulkan-loader
    libglvnd
    libva
    pipewire
    alsa-lib
    libxkbcommon
    wayland
  ];

  platforms = lib.platforms.darwin ++ [
    "x86_64-linux"
    "aarch64-linux"
  ];
}
