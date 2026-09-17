{
  stdenv,
  python3,
  python3Packages,
  installShellFiles,
}:

let
  pythonEnv = python3.withPackages (p: [ p.huggingface-hub ]);
in
stdenv.mkDerivation {
  pname = "hf";
  version = python3Packages.huggingface-hub.version;

  nativeBuildInputs = [
    installShellFiles
    pythonEnv
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    ln -s ${python3Packages.huggingface-hub}/bin/hf $out/bin/hf

    hfCompletion() {
      python3 -c "from typer.completion import get_completion_script; print(get_completion_script(prog_name='hf', complete_var='_HF_COMPLETE', shell='$1'))"
    }

    installShellCompletion --cmd hf \
      --bash <(hfCompletion bash) \
      --fish <(hfCompletion fish) \
      --zsh <(hfCompletion zsh)

    runHook postInstall
  '';

  meta = {
    description = "Hugging Face Hub CLI";
    mainProgram = "hf";
    license = python3Packages.huggingface-hub.meta.license;
  };
}
