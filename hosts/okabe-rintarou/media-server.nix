{
  # DLNA Server
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "okabe-rintarou";
      media_dir = ["V,/mnt/hdd/Videos/"];
      inotify = "yes";
      notify_interval = 30;
    };
  };
}
