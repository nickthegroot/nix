{
  programs.opencode = {
    enable = true;

    skills = {
      caveman = ./skills/caveman.md;
      commit = ./skills/commit.md;
    };

    settings.autoupdate = false;

    context = ''
      /caveman

      ## Code Style

      - Focus on writing self-explanatory code with meaningful variable and function names
        - Complex functions should be broken down into smaller, more manageable pieces to enhance readability and maintainability
        - Use comments sparingly and only in situations where the code's intent cannot be made clear (e.g. using external services)
      - Make heavy usage of types and interfaces to ensure type safety and make assumptions explicit
        - All inputs and outputs of functions should always be typed
    '';
  };
}
