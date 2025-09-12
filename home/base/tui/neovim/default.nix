{
  pkgs,
  mylib,
  nixvim,
  ...
}:
{
  imports = [ nixvim.homeModules.nixvim ] ++ (mylib.scanPaths ./.);

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    nixpkgs.useGlobalPackages = true;

    luaLoader.enable = true;
    extraPackages = with pkgs; [
      ripgrep
      lazygit
      fzf
      fd
    ];
  };

  home.shellAliases = {
    "n" = "nvim";
  };
}
