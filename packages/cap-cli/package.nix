{
  lib,
  stdenv,
  pkgs,
  rustPlatform,
  pkg-config,
  cmake,
  clang,
  llvmPackages,
  autoPatchelfHook,
  ffmpeg_7,
  libiconv,
  zlib,
  bzip2,
}:

let
  cap = pkgs.callPackage ./common.nix { };

  inherit (cap)
    version
    capSrc
    cidrePatch
    linuxBuildInputs
    platforms
    ;
in
rustPlatform.buildRustPackage {
  pname = "cap-cli";
  inherit version;
  src = capSrc;
  cargoRoot = ".";
  cargoHash = "sha256-c/Mb/xSgrvwN6iDBo68qGyXl1irxAdIGKDCT4UQADTk=";

  patches = [ ./disable-update.patch ];

  nativeBuildInputs = [
    pkg-config
    cmake
    clang
    llvmPackages.libclang
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];

  # cidre's build.rs runs xcodebuild for pomace's static libraries; build them with clang instead.
  postPatch = ''
    set -- "$cargoDepsCopy"/source-git-*/cidre-*
    [ -f "$1/build.rs" ] || { echo "cidre vendor directory missing" >&2; exit 1; }
    patch -p1 -d "$1" < ${cidrePatch}
  '';

  buildInputs = [
    ffmpeg_7
    libiconv
    zlib
    bzip2
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux linuxBuildInputs;

  env = {
    LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
  }
  // lib.optionalAttrs stdenv.hostPlatform.isDarwin {
    MACOSX_DEPLOYMENT_TARGET = "12.3";
  };

  cargoBuildFlags = [
    "--package"
    "cap"
  ];

  doCheck = false;

  installPhase = ''
    runHook preInstall
    install -Dm755 "target/${stdenv.hostPlatform.rust.rustcTarget}/''${cargoBuildType}/cap" "$out/bin/cap"
    runHook postInstall
  '';

  meta = {
    description = "Cap command-line interface";
    homepage = "https://github.com/CapSoftware/Cap";
    license = lib.licenses.agpl3Only;
    mainProgram = "cap";
    inherit platforms;
  };
}
