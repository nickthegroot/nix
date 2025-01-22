{pkgs, ...}: {
  services.sketchybar = {
    enable = true;
    extraPackages = with pkgs; [
      lua5_4
    ];
  };
}
