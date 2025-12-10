{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  programs = {
    qutebrowser = {
      enable = true;

      # Use brew version on darwin
      # until can set as primary browser (e.g. properly build/register plist)
      # (also fix .qutebrowser-wrapped popup every launch)
      package = if stdenv.isDarwin then null else pkgs.qutebrowser;

      settings = {
        window.hide_decoration = true;

        colors.webpage.darkmode = {
          enabled = true;
          algorithm = "lightness-cielab";
          policy.images = "never";
        };

        content.pdfjs = true; # auto show pdf in pdfjs

        auto_save = {
          interval = 10000;
          session = true;
        };
      };
      keyBindings = {
        normal = {
          "tT" = "config-cycle tabs.position top left";
          "tD" = "config-cycle statusbar.show always never";
          "td" = "config-cycle -p -u *://{url:host}/* colors.webpage.darkmode.enabled false true ;; reload";
        };
      };
      searchEngines = {
        DEFAULT = "https://duckduckgo.com/?q={}";
        g = "https://www.google.com/search?hl=en&amp;q={}";
        ai = "https://duckduckgo.com/?q={}&ia=chat&bang=true";
        aio = "https://chat.openai.com/?q={}";
        nx = "https://mynixos.com/search?q={}";
        nxv = "https://nix-community.github.io/nixvim/?search={}";
        gh = "https://github.com/search?o=desc&q={}&s=stars";
        wp = "https://en.wikipedia.org/w/index.php?search={}";
        wt = "https://wikitravel.org/en/Special:Search?search={}&go=Go";
        so = "https://stackoverflow.com/search?q={}";
        yt = "https://www.youtube.com/results?search_query={}";
        jp = "https://jisho.org/search/{}";
        tr = "https://translate.google.com/?sl=auto&tl=en&text={}&op=translate";
      };
    };

    brave = {
      enable = true;

      # Use brew version on darwin
      # until home-manager version supports 1password desktop app integration
      package = if stdenv.isDarwin then null else pkgs.brave;

      extensions = [
        { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium (manually need to apply vimium-options.json)
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # YouTube SponsorBlock
        { id = "enamippconapkdmgfgjchkhakpfinmaj"; } # DeArray (YouTube Clickbait Remover)
      ];
    };
  };
}
