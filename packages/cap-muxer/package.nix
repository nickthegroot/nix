{
  lib,
  stdenv,
  pkgs,
  rustPlatform,
  pkg-config,
  autoPatchelfHook,
  ffmpeg_7,
}:

let
  cap = pkgs.callPackage ../cap-cli/common.nix { };

  inherit (cap) version capSrc platforms;
in
rustPlatform.buildRustPackage {
  pname = "cap-muxer";
  inherit version;
  src = capSrc;
  cargoRoot = ".";
  cargoHash = "sha256-c/Mb/xSgrvwN6iDBo68qGyXl1irxAdIGKDCT4UQADTk=";

  nativeBuildInputs = [
    pkg-config
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];

  buildInputs = [ ffmpeg_7 ];

  cargoBuildFlags = [
    "--package"
    "cap-muxer"
  ];

  doCheck = false;

  installPhase = ''
    runHook preInstall
    install -Dm755 "target/${stdenv.hostPlatform.rust.rustcTarget}/''${cargoBuildType}/cap-muxer" "$out/bin/cap-muxer"
    runHook postInstall
  '';

  meta = {
    description = "Cap fragmented-MP4 muxer sidecar";
    homepage = "https://github.com/CapSoftware/Cap";
    license = lib.licenses.agpl3Only;
    mainProgram = "cap-muxer";
    inherit platforms;
  };
}
