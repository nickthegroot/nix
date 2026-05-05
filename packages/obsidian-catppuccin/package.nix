{
  fetchFromGitHub,
  fetchPnpmDeps,
  nodejs,
  pnpm_10,
  pnpmConfigHook,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "catppuccin-obsidian";
  version = "55aa9c9036a9df864593fdaedb2a227d3823fb06";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "obsidian";
    rev = version;
    hash = "sha256-uB0a2nSZkHHf65xBYXyNh50vaAiqdEpKQVf3eXnCVlE=";
  };

  nativeBuildInputs = [
    nodejs
    pnpmConfigHook
    pnpm_10
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 3;
    hash = "sha256-WgthXRObQ3zojRAYZ4AYKTCJZuUprq9AwtaEg8wApIQ=";
  };

  buildPhase = ''
    pnpm run build
  '';

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./dist/catppuccin.css $out/theme.css
  '';
})
