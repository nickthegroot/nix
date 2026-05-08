{
  # Recommended for pipewire
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  services = {
    playerctld.enable = true;
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
    xone.enable = true;
    steam-hardware.enable = true;
  };
}
