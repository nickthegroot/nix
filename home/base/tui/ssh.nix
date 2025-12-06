{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # deprecated
    includes = [
      "~/.ssh/hosts_config" # https://developer.1password.com/docs/ssh/agent/advanced#use-multiple-github-accounts
      "~/.ssh/1Password/config" # https://developer.1password.com/docs/ssh/bookmarks/
    ];

    matchBlocks = {
      "*" = {
        identityAgent =
          if pkgs.stdenv.isDarwin then
            "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
          else
            "~/.1password/agent.sock";
      };
    };
  };
}
