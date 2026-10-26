{
  lib,
  stdenv,
  pkgs,
  runCommand,
  rustPlatform,
  pkg-config,
  cmake,
  clang,
  llvmPackages,
  ffmpeg_7,
  onnxruntime,
  autoPatchelfHook,
  makeWrapper,
  pulseaudio,
  libiconv,
  zlib,
  bzip2,
}:

let
  cap = pkgs.callPackage ../cap-cli/common.nix { };

  inherit (cap)
    version
    capSrc
    cidrePatch
    linuxBuildInputs
    platforms
    ;

  zedGpui = pkgs.callPackage ../zed-gpui/package.nix { };
  capCli = pkgs.callPackage ../cap-cli/package.nix { };
  capMuxer = pkgs.callPackage ../cap-muxer/package.nix { };

  source = runCommand "cap-desktop-source-${version}" { } ''
    mkdir -p "$out"
    cp -a ${capSrc} "$out/cap"
    cp -a ${zedGpui} "$out/zed-cap"
  '';

  sharedEnv = {
    ORT_LIB_LOCATION = "${onnxruntime}/lib";
    ORT_PREFER_DYNAMIC_LINK = "1";
    LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
  };
in
rustPlatform.buildRustPackage {
  pname = "cap-desktop";
  inherit version;
  src = source;
  sourceRoot = "cap-desktop-source-${version}";
  cargoRoot = "cap/apps/desktop-gpui";
  buildAndTestSubdir = "cap/apps/desktop-gpui";
  cargoHash = "sha256-SDTKvXsZIto8lYnMTeRS2QlWPM0KEvNY2aqojOshODM=";

  patches = [ ./disable-updates.patch ];

  nativeBuildInputs = [
    pkg-config
    cmake
    clang
    llvmPackages.libclang
    makeWrapper
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    autoPatchelfHook
    rustPlatform.bindgenHook
  ];

  # cidre's build.rs runs xcodebuild for pomace's static libraries; build them with clang instead.
  postPatch = ''
    set -- "$cargoDepsCopy"/source-git-*/cidre-*
    [ -f "$1/build.rs" ] || { echo "cidre vendor directory missing" >&2; exit 1; }
    patch -p1 -d "$1" < ${cidrePatch}
  '';

  runtimeDependencies = lib.optionals stdenv.hostPlatform.isLinux cap.runtimeDependencies;

  buildInputs = [
    ffmpeg_7
    onnxruntime
    libiconv
    zlib
    bzip2
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux linuxBuildInputs;

  env =
    sharedEnv
    // lib.optionalAttrs stdenv.hostPlatform.isDarwin {
      MACOSX_DEPLOYMENT_TARGET = "12.3";
    };

  doCheck = false;

  installPhase = ''
    runHook preInstall

    if ${if stdenv.hostPlatform.isDarwin then "true" else "false"}; then
      app="$out/Applications/Cap.app"
      mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources/assets/music"
      install -m755 "target/${stdenv.hostPlatform.rust.rustcTarget}/''${cargoBuildType}/cap-gpui" "$app/Contents/MacOS/Cap"
      install -m755 ${capCli}/bin/cap "$app/Contents/MacOS/cap-cli"
      install -m755 ${capMuxer}/bin/cap-muxer "$app/Contents/MacOS/cap-muxer"
      install -Dm755 ${onnxruntime}/lib/libonnxruntime.dylib \
        "$app/Contents/Resources/onnxruntime/lib/libonnxruntime.dylib"
      install -m644 ${capSrc}/apps/desktop/src-tauri/icons/macos/icon.icns "$app/Contents/Resources/icon.icns"
      cp -r ${capSrc}/apps/desktop/src-tauri/assets/backgrounds "$app/Contents/Resources/assets/backgrounds"
      cp ${capSrc}/apps/desktop/src/assets/music/*.mp3 "$app/Contents/Resources/assets/music/"
      substitute ${./Info.plist} "$app/Contents/Info.plist" \
        --replace-fail '@VERSION@' "${version}"
      mkdir -p "$out/bin"
      ln -s "$app/Contents/MacOS/Cap" "$out/bin/Cap"
    else
      install -Dm755 "target/${stdenv.hostPlatform.rust.rustcTarget}/''${cargoBuildType}/cap-gpui" "$out/bin/Cap"
      install -Dm755 ${capCli}/bin/cap "$out/bin/cap-cli"
      install -Dm755 ${capMuxer}/bin/cap-muxer "$out/bin/cap-muxer"
      wrapProgram "$out/bin/Cap" \
        --prefix PATH : ${lib.makeBinPath [ pulseaudio ]}

      install -Dm755 ${onnxruntime}/lib/libonnxruntime.so "$out/lib/cap/libonnxruntime.so"

      mkdir -p "$out/lib/cap/assets/music"
      cp -r ${capSrc}/apps/desktop/src-tauri/assets/backgrounds "$out/lib/cap/assets/backgrounds"
      cp ${capSrc}/apps/desktop/src/assets/music/*.mp3 "$out/lib/cap/assets/music/"

      install -Dm644 ${capSrc}/apps/desktop/src-tauri/icons/icon.png \
        "$out/share/icons/hicolor/512x512/apps/so.cap.desktop.png"
      install -Dm644 ${./cap.desktop} "$out/share/applications/so.cap.desktop.desktop"
    fi

    runHook postInstall
  '';

  meta = {
    description = "Open source Loom alternative for screen recording and sharing";
    homepage = "https://github.com/CapSoftware/Cap";
    license = lib.licenses.agpl3Only;
    mainProgram = "Cap";
    inherit platforms;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
