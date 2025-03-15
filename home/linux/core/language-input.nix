{ pkgs, ... }:
{
  catppuccin.fcitx5.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-configtool
      fcitx5-mozc
      fcitx5-gtk # gtk im module
    ];
  };
}
