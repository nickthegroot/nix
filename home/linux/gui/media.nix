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
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        keep-open = "yes";
        gpu-context = "wayland";
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
