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
    extraConfig = ''
      IdentityAgent ${opPath}
    '';
  };
}
