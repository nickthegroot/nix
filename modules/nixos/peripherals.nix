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
    xone.enable = true;
    steam-hardware.enable = true;
    opentabletdriver.enable = true;
  };
}
