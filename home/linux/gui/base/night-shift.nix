{pkgs, ...}: {
  # Adjust the color temperature(& brightness) of your screen according to
  # your surroundings. This may help your eyes hurt less if you are
  # working in front of the screen at night.
  #
  # works fine with both x11 & wayland(hyprland)
  #
  # https://gitlab.com/chinstrap/gammastep
  services.gammastep = {
    enable = true;
    # add a gammastep icon in the system tray
    # has problem with wayland, so disable it
    tray = false;
    temperature = {
      day = 5700;
      night = 3200;
    };
    # https://gitlab.com/chinstrap/gammastep/-/blob/master/gammastep.conf.sample?ref_type=heads
    settings = {
      general = {
        fade = "1";
        brightness-day = "1.0";
        brightness-night = "0.8";
        location-provider = "manual";
      };
      manual = {
        # Portland, OR
        lat = "45.5";
        lon = "-122.7";
      };
    };
  };
}
