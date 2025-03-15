{ wallpapers, pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm; # required for catppuccin port
  };

  catppuccin.sddm = {
    enable = true;
    background = "${wallpapers}/by_burned_2560.jpg";
  };
}
