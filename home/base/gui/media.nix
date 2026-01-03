{ pkgs, ... }:
let
  youtubeMusicThemeSrc = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "youtubemusic";
    rev = "dc35fc46232e389ff761adec8242f956af405880";
    sha256 = "sha256-K5iwNBA/6/JDmmt/u9Dnsk0lvWY12YpY+BIScrRaDGw=";
  };
in
{
  home.packages = with pkgs; [
    pear-desktop # renamed: youtube-music
  ];

  xdg.configFile."YouTube Music/CustomThemes/catppuccin".source = youtubeMusicThemeSrc + "/src";
}
