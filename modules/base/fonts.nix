{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      noto-fonts-color-emoji
      source-sans
      source-serif
      source-han-sans # CJK Support
      source-han-serif # CJK Support

      nerd-fonts.jetbrains-mono
      julia-mono
    ];
  };
}
