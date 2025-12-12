{ pkgs, ... }:
{
  catppuccin.fcitx5 = {
    enable = true;
    # Currently causing issues with catpuccin config:
    # > Error installing file '.config/fcitx5/conf/classicui.conf' outside $HOME
    # Instead, just manually apply
    apply = false;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-configtool
        fcitx5-mozc # jp input
        fcitx5-gtk # im module
      ];

      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "mozc";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "mozc";
      };
    };
  };
}
