{ inputs, lib, myvars, ... }:
{
  imports = [ inputs.jovian.nixosModules.default ];

  jovian = {
    devices.steamdeck.enable = true;

    steam = {
      enable = true;
      autoStart = true;
      user = myvars.username;
      desktopSession = "hyprland";
    };
  };

  programs.steam.gamescopeSession.enable = lib.mkForce false;
  hardware.xone.enable = lib.mkForce false;
}
