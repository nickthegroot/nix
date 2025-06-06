{ pkgs, ... }:
{
  # TODO: sort into appropriate modules
  home.packages = with pkgs; [
    xh
    caligula
    pastel
    astroterm
    # durdraw - need to package ourselves
  ];
}
