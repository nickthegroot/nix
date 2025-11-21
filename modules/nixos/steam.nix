{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # was having minor issues without this
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
