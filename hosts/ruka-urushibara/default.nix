# Personal Laptop, 2021 M1 MacBook Pro running Asahi
{
  name = "ruka-urushibara";
  nixos-modules = [
    ./hardware-configuration.nix
    ./apple-silicon.nix
  ];
  home-modules = [ ];
}
