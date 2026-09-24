{ lib, ... }:
{
  # Common dev ports
  networking.firewall.allowedTCPPorts = lib.range 8080 8090;
}
