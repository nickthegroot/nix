{ catppuccin, ... }:
{
  imports = [ catppuccin.homeModules.catppuccin ];

  catppuccin = {
    flavor = "mocha";
    enable = true;
    nvim.enable = false; # use our own custom config
  };
}
