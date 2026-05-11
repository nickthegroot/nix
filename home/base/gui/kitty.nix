{ pkgs, ... }:
let
  kitty-icon = pkgs.fetchFromGitHub {
    owner = "sodapopcan";
    repo = "kitty-icon";
    rev = "7496efa44f2f4615580471eebce7333459454731";
    hash = "sha256-TWLJbIdQf1SHZQA3GfdIjWfsHZ/Dsfpq49nqCRDR16E=";
  };
in
{
  xdg.configFile."kitty/kitty.app.png".source = "${kitty-icon}/kitty.app.png";

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.93";
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish --login --interactive";
      macos_show_window_title_in = "none";

      hide_window_decorations = "yes";
      background_blur = 10;

      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";

      enabled_layouts = "splits:split_axis=horizontal";
    };

    actionAliases = {
      kitty_scrollback_nvim = "kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py";
    };

    keybindings = {
      # Tabs
      "ctrl+a>c" = "new_tab_with_cwd";
      "ctrl+a>x" = "close_tab";
      "ctrl+a>o" = "close_other_tabs_in_os_window";
      "ctrl+a>comma" = "set_tab_title";

      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
      "ctrl+7" = "goto_tab 7";
      "ctrl+8" = "goto_tab 8";
      "ctrl+9" = "goto_tab 9";

      # Windows (aka panes)
      "ctrl+a>h" = "launch --location=hsplit --cwd=current";
      "ctrl+a>v" = "launch --location=vsplit --cwd=current";
      "ctrl+a>d" = "close_window";

      "ctrl+h" = "neighboring_window left";
      "ctrl+j" = "neighboring_window down";
      "ctrl+k" = "neighboring_window up";
      "ctrl+l" = "neighboring_window right";

      # Scrollback
      "ctrl+a>left_bracket" = "kitty_scrollback_nvim";
      "ctrl+a>right_bracket" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";

      # Misc
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    mouseBindings = {
      # Show clicked cmd output in nvim
      "ctrl+shift+right press" =
        "ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output";
    };

    extraConfig = ''
      map --when-focus-on var:IS_VIM=true ctrl+h
      map --when-focus-on var:IS_VIM=true ctrl+j
      map --when-focus-on var:IS_VIM=true ctrl+k
      map --when-focus-on var:IS_VIM=true ctrl+l
    '';
  };

  programs.nixvim = {
    plugins = {
      kitty-navigator.enable = true;
      kitty-scrollback.enable = true;
    };
  };
}
