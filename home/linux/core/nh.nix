{ myvars, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/${myvars.username}/.dotfiles/";
  };
}
