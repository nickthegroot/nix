{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # video
    ffmpeg-full
    yt-dlp
    ani-cli

    # images
    imagemagick
    graphviz
  ];
}
