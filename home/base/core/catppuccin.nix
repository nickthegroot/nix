{ catppuccin, ... }:
{
  imports = [ catppuccin.homeModules.catppuccin ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    enable = true;
    nvim.enable = false; # use our own custom config
  };
}
