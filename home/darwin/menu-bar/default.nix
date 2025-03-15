{ config, ... }:
{
  xdg.configFile."sketchybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/darwin/menu-bar/config";
}
