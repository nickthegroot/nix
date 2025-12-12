{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "nickthegroot";
    repo = "wallpapers";
    rev = "6f6afd8a9758bb4cdf54ad29370bbc68c9476e67";
    hash = "sha256-Oq16yG1MA72qT/+m0jrmK/7/S3yfquqyZJHUuSkBDFI=";
  };
in
{
  home.file."Pictures/Wallpapers" = {
    recursive = true;
    source = src;
  };
}
