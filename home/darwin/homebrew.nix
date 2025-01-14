{
  programs.fish.loginShellInit = ''
    /opt/homebrew/bin/brew shellenv fish | source
  '';
}
