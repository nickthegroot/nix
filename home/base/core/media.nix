{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    imagemagick
  ];

  programs.sioyek = {
    enable = true;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "h";
      "move_right" = "l";
      "screen_down" = "<C-d>";
      "screen_up" = "<C-u>";
    };
  };
}
