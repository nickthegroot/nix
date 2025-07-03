{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Video
    ffmpeg-full
    yt-dlp

    # Audio
    imagemagick
  ];
}
