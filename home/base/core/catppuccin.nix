{ catppuccin, ... }:
{
  imports = [ catppuccin.homeModules.catppuccin ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    enable = true;
    lazygit.enable = false; # waiting on catppuccin/nix#1049 backport to release-26.05
    nvim.enable = false; # use our own custom config
    vscode.profiles.default.enable = false; # currently using insecure pnpm. disabled until fixed upstream.
  };
}
