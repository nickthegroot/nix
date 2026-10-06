{ lib, ... }:
{
  networking.firewall.allowedTCPPorts = [ 3000 ] ++ lib.range 8080 8090;
}
