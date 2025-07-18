{ pkgs, ... }:
let
  opPath =
    if pkgs.stdenv.isLinux then
      "~/.1password/agent.sock"
    else
      "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/hosts_config" ]; # local & remote servers
    extraConfig = ''
      IdentityAgent ${opPath}
    '';
  };
}
