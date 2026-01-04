{ pkgs, ... }:
{
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
      ];
    };

    imv.enable = true;
    cava.enable = true;
  };

  home.packages = with pkgs; [
    kdePackages.dolphin
  ];
}
