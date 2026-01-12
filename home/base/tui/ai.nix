{
  programs.opencode = {
    enable = true;
    settings = {
      mcp = {
        linear = {
          type = "remote";
          url = "https://mcp.linear.app/mcp";
        };
        # https://github.com/anomalyco/opencode/issues/5636
        # figma = {
        #   type = "remote";
        #   url = "https://mcp.figma.com/mcp";
        # };
      };
    };
  };
}
