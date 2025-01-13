{ wallpapers, ... }: {
  home.file."Pictures/Wallpapers" = {
    recursive = true;
    source = wallpapers;
  };
}
