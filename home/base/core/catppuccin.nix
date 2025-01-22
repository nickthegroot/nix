{catppuccin, ...}: {
  imports = [catppuccin.homeManagerModules.catppuccin];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.nvim.enable = false; # use our own custom config
}
