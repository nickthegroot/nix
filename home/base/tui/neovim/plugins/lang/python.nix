{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "venv-selector";
        nvimSkipModule = [
          "venv-selector.cached_venv"
        ];
        src = pkgs.fetchFromGitHub {
          owner = "stefanboca";
          repo = "venv-selector.nvim";
          rev = "e7b8c42c1cdd60d70d24463b5108231d695cf67e";
          hash = "sha256-bfuZVJ7NnveU+jFA+HAb/buAOmMAHNg5tKfYNtBAy6Q=";
        };
      })
    ];
    extraConfigLua = ''
      require("venv-selector").setup()
    '';

    plugins = {
      conform-nvim.settings = {
        formatters_by_ft.python = [
          "ruff_format"
          "ruff_organize_imports"
        ];
      };

      lint = {
        lintersByFt.python = [ "mypy" ];
        linters.mypy = {
          cmd = "${pkgs.mypy}/bin/mypy";
          args = [ "--ignore-missing-imports" ];
        };
      };

      lsp.servers = {
        pyright = {
          enable = true;
          extraOptions.settings = {
            # Using Ruff's import organizer
            pyright.disableOrganizeImports = true;
          };
        };

        ruff = {
          enable = true;
          onAttach.function = ''
            if client.name == 'ruff' then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          '';
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
        ];
        key = "<leader>rv";
        action = ":VenvSelect<CR>";
        options = {
          silent = true;
          desc = "Select python environment";
        };
      }
    ];
  };
}
