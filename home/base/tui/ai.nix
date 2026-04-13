{ pkgs, ... }:
let
  caveman = pkgs.fetchFromGitHub {
    owner = "JuliusBrussee";
    repo = "caveman";
    tag = "v1.5.1";
    hash = "sha256-gDPgQx1TIhGrJ2EVvEoDY+4MXdlI79zdcx6pL5nMEG4=";
  };
in
{
  programs.opencode = {
    enable = true;

    skills = {
      caveman = "${caveman}/skills/caveman";
      caveman-commit = "${caveman}/skills/caveman-commit";
      caveman-review = "${caveman}/skills/caveman-review";
    };

    settings = {
      autoupdate = false;

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
    rules = ''
      ## Code Style

      - Focus on writing self-explanatory code with meaningful variable and function names
        - Complex functions should be broken down into smaller, more manageable pieces to enhance readability and maintainability
        - Use comments sparingly and only in situations where the code's intent cannot be made clear (e.g. using external services)
      - Make heavy usage of types and interfaces to ensure type safety and make assumptions explicit
        - All inputs and outputs of functions should always be typed
    '';
  };
}
