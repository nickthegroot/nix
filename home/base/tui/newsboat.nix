{
  programs.newsboat = {
    enable = true;

    autoReload = true;
    urls = [
      {
        url = "https://news.ycombinator.com/rss";
        title = "Hacker News";
      }
      {
        url = "https://feeds.npr.org/1002/rss.xml";
        title = "NPR Top Stories";
      }
      {
        url = "https://xkcd.com/rss.xml";
        title = "XKCD";
      }
      {
        url = "https://raw.githubusercontent.com/huangboming/huggingface-daily-paper-feed/refs/heads/main/feed_weekly.xml";
        title = "HuggingFace Papers - Trending";
      }
      {
        url = "https://overreacted.io/rss.xml";
        title = "overreacted - Dan Abramov";
      }
      {
        url = "https://registerspill.thorstenball.com/feed";
        title = "Register Spill - Thorsten Ball";
      }
      {
        url = "https://world.hey.com/dhh/feed.atom";
        title = "Hey - DHH";
      }
      {
        url = "https://nixos.org/blog/announcements-rss.xml";
        title = "NixOS Releases";
      }
      {
        url = "https://asahilinux.org/blog/index.xml";
        title = "Asahi Linux Blog";
      }
    ];

    # https://m-chrzan.xyz/blog/vim-keybindings-for-newsboat.html
    extraConfig = ''
      # jk - move up/down
      unbind-key j
      unbind-key k
      bind-key j down
      bind-key k up

      # hl - move in/out of feeds/articles
      bind-key h quit
      bind-key l open

      # q quits the program
      unbind-key q
      bind-key q hard-quit

      # g/G to go to top/bottom
      unbind-key g
      unbind-key G
      bind-key g home
      bind-key G end

      # f to follow links (like qutebrowser)
      unbind-key f
      bind-key f goto-url
    '';
  };
}
