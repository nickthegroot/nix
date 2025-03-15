{ wallpapers, ... }:
{
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = wallpapers;
        duration = "10m";
        sorting = "random";
        mode = "center";
      };
    };
  };
}
