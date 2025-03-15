{
  services.gammastep = {
    enable = true;
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
