{
  # Recommended for pipewire
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    blueman.enable = true;
    udisks2.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
    xone.enable = true;
    steam-hardware.enable = true;
  };

  # KDE Connect (phone) Ports
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
