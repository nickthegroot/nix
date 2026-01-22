{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
    xdg-user-dirs
  ];

  xdg.configFile."mimeapps.list".force = true;
  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    mimeApps = {
      enable = true;
      # let `xdg-open` to open the url with the correct application.
      defaultApplications =
        let
          browser = [ "brave-browser.desktop" ];
          editor = [ "nvim.desktop" ];
          fileManager = [ "org.kde.dolphin" ];
          videoPlayer = [ "mpv.desktop" ];
          imageViewer = [ "imv-dir.desktop" ];
        in
        {
          "text/html" = browser;
          "application/pdf" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;

          "text/plain" = editor;
          "text/xml" = editor;
          "application/json" = editor;
          "application/xml" = editor;

          "inode/directory" = fileManager;

          "audio/mpeg" = videoPlayer;
          "audio/mp3" = videoPlayer;
          "audio/ogg" = videoPlayer;
          "audio/wav" = videoPlayer;
          "audio/flac" = videoPlayer;
          "audio/x-wav" = videoPlayer;

          "video/mp4" = videoPlayer;
          "video/x-matroska" = videoPlayer;
          "video/webm" = videoPlayer;
          "video/ogg" = videoPlayer;
          "video/avi" = videoPlayer;
          "video/x-msvideo" = videoPlayer;
          "video/mpeg" = videoPlayer;

          "image/png" = imageViewer;
          "image/jpeg" = imageViewer;
          "image/gif" = imageViewer;
          "image/webp" = imageViewer;
          "image/bmp" = imageViewer;
          "image/svg+xml" = imageViewer;
        };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
