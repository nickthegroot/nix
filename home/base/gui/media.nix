{ pkgs, ... }:
# processing audio/video
{
  home.packages = with pkgs; [
    ffmpeg-full

    # images
    imagemagick
    graphviz

    yt-dlp
    ani-cli
    ani-skip
  ];
}
