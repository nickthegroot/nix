{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard # copying and pasting
    hyprpicker # color picker
    hyprshot # screen shot
  ];
}
