{
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    # Helpful for SteamVR
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
