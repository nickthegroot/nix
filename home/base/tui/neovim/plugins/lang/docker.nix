{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lint = {
        lintersByFt = {
          docker = [ "hadolint" ];
        };

        linters = {
          hadolint = {
            cmd = "${pkgs.hadolint}/bin/hadolint";
          };
        };
      };
    };

    lsp.servers = {
      dockerls.enable = true;
      docker_compose_language_service.enable = true;
    };
  };
}
