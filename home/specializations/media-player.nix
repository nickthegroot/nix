{
  config,
  lib,
  ...
}:
let
  cfg = config.media-player;
in
{
  options.media-player = {
    enable = lib.mkEnableOption "Media player tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    programs.brave.extensions = [
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # YouTube SponsorBlock
      { id = "enamippconapkdmgfgjchkhakpfinmaj"; } # DeArray (YouTube Clickbait Remover)
      { id = "khncfooichmfjbepaaaebmommgaepoid"; } # YouTube Unhook (Remove Recommended, Trending, etc.)
      { id = "ammjkodgmmoknidbanneddgankgfejfh"; } # 7tv (Twitch Emotes)
    ];
  };
}
