{ myvars, ... }:
{
  programs.nh = {
    enable = true;
    osFlake = "/home/${myvars.username}/.dotfiles/";
    darwinFlake = "/Users/${myvars.username}/.dotfiles/";

    clean = {
      enable = true;
      dates = "weekly";
    };
  };
}
