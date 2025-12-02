{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Video
    ffmpeg
    yt-dlp

    # Audio
    imagemagick
  ];
}
