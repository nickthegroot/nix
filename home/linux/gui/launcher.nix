{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
      rofi-games
    ];
    modes = [
      "drun"
      "games"
      "emoji"
      "calc"
    ];
    extraConfig = {
      kb-cancel = "Caps_Lock";
    };
  };
}
