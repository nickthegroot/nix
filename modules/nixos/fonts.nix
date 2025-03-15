{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      noto-fonts-emoji
      source-sans
      source-serif
      source-han-sans # CJK Support
      source-han-serif # CJK Support

      nerd-fonts.jetbrains-mono
      julia-mono
    ];

    # user defined fonts
    fontconfig.defaultFonts = {
      serif = [
        "Source Han Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Source Han Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
