{pkgs, ...}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer

    # video/audio tools
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
    gimp

    youtube-music
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
