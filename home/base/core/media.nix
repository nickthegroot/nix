{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    imagemagick
  ];

  # Currently broken on linux
  # https://github.com/NixOS/nixpkgs/issues/432137
  programs.sioyek.enable = pkgs.stdenv.isDarwin;
}
