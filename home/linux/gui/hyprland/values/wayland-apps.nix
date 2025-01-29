{
  pkgs,
  zen-browser,
  ...
}: {
  home.packages = [
    zen-browser.packages.${pkgs.system}.default
  ];

  programs = {
    # source code: https://github.com/nix-community/home-manager/blob/master/modules/programs/chromium.nix
    google-chrome = {
      enable = true;

      # https://wiki.archlinux.org/title/Chromium#Native_Wayland_support
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
      ];
    };

    vscode = {
      enable = true;
      package =
        pkgs.vscode.override
        {
          # https://wiki.archlinux.org/title/Wayland#Electron
          commandLineArgs = [
            "--ozone-platform-hint=auto"
            "--ozone-platform=wayland"
          ];
        };
    };
  };
}
