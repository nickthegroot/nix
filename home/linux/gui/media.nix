{pkgs, ...}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    # audio control
    playerctl
    pavucontrol # gui for audio io
    alsa-utils # provides amixer/alsamixer/...

    youtube-music
    gimp
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
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

  services = {
    playerctld.enable = true;
  };
}
