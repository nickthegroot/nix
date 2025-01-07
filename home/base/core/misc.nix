{pkgs, myvars, ...}: {
  home.packages = with pkgs; [
    ani-cli
  ];

  programs.nh = {
    enable = true;
    flake = "/home/${myvars.username}/.dotfiles/";
  };
}
