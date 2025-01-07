{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/base/tui/editors/neovim/nvim";

  programs = {
    neovim = {
      enable = true;

      # defaultEditor = true; # set EDITOR at system-wide level
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
    };
  };

  home.shellAliases = {
    n = "nvim";
  };
}
