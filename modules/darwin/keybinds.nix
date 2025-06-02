{
  services.aerospace.settings.mode = {
    # All possible keys:
    # - Letters.        a, b, c, ..., z
    # - Numbers.        0, 1, 2, ..., 9
    # - Keypad numbers. keypad0, keypad1, keypad2, ..., keypad9
    # - F-keys.         f1, f2, ..., f20
    # - Special keys.   minus, equal, period, comma, slash, backslash, quote, semicolon,
    #                   backtick, leftSquareBracket, rightSquareBracket, space, enter, esc,
    #                   backspace, tab, pageUp, pageDown, home, end, forwardDelete,
    #                   sectionSign (ISO keyboards only, european keyboards only)
    # - Keypad special. keypadClear, keypadDecimalMark, keypadDivide, keypadEnter, keypadEqual,
    #                   keypadMinus, keypadMultiply, keypadPlus
    # - Arrows.         left, down, up, right
    # All possible modifiers: cmd, alt, ctrl, shift
    # All possible commands: https://nikitabobko.github.io/AeroSpace/commands
    main.binding =
      {
        alt-h = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors left";
        alt-j = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors down";
        alt-k = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors up";
        alt-l = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        ctrl-alt-h = "focus-monitor left";
        ctrl-alt-j = "focus-monitor down";
        ctrl-alt-k = "focus-monitor up";
        ctrl-alt-l = "focus-monitor right";

        ctrl-alt-shift-h = "move-node-to-monitor left";
        ctrl-alt-shift-j = "move-node-to-monitor down";
        ctrl-alt-shift-k = "move-node-to-monitor up";
        ctrl-alt-shift-l = "move-node-to-monitor right";

        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";
      }
      // {
        alt-enter = "exec-and-forget open -a Ghostty";
        alt-shift-enter = "exec-and-forget open -a Zed";
        alt-space = "exec-and-forget open -a qutebrowser";

        ctrl-alt-shift-m = "exec-and-forget open -a \"YouTube Music\"";
        ctrl-alt-shift-s = "exec-and-forget open -a Slack";
        ctrl-alt-shift-n = "exec-and-forget open -a Notion";
        ctrl-alt-shift-c = "exec-and-forget open -a \"Notion Calendar\"";
      }
      // (
        # workspaces 1-9
        builtins.foldl' (acc: elem: acc // elem) { } (
          builtins.genList (
            i:
            let
              ws = toString (i + 1);
            in
            {
              "alt-${ws}" = "workspace ${ws}";
              "alt-shift-${ws}" = "move-node-to-workspace ${ws} --focus-follows-window";
            }
          ) 9
        )
      );
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
