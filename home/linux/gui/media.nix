{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # audio control
    playerctl
    pavucontrol # gui for audio io

    youtube-music
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      config = {
        keep-open = "yes";
      };
      scripts = with pkgs.mpvScripts; [
        mpris
        modernz
        thumbfast
        vr-reversal
      ];
    };

    imv.enable = true;

    cava.enable = true;
  };
}
