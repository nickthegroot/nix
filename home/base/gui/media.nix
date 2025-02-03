{
  pkgs,
  config,
  ...
}:
# processing audio/video
{
  home.packages = with pkgs; [
    ffmpeg-full

    # images
    viu # Terminal image viewer
    imagemagick
    graphviz

    yt-dlp
    ani-cli
  ];
}
