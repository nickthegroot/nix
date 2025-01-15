{
  pkgs,
  lib,
  ...
}: {
  # required for greeting
  home.packages = with pkgs; [
    fortune
    cowsay
    lolcat
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings

      if not set -q TMUX
        tmux new-session -A -s main
      end
    '';
    functions = {
      fish_greeting = "fortune | cowsay | lolcat";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
    ];
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.fish}/bin/fish -c "tide configure \
    --auto \
    --style=Classic \
    --prompt_colors='True color' \
    --classic_prompt_color=Dark \
    --show_time='12-hour format' \
    --classic_prompt_separators=Angled \
    --powerline_prompt_heads=Sharp \
    --powerline_prompt_tails=Flat \
    --powerline_prompt_style='Two lines, frame' \
    --prompt_connection=Solid \
    --powerline_right_prompt_frame=No \
    --prompt_connection_andor_frame_color=Light \
    --prompt_spacing=Sparse \
    --icons='Many icons' \
    --transient=No"
  '';
}
