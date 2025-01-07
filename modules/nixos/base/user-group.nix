{myvars, ...}: {
  # Don't allow mutation of users outside the config.
  # users.mutableUsers = false;

  users.groups = {
    "${myvars.username}" = {};
    docker = {};
  };

  users.users."${myvars.username}" = {
    home = "/home/${myvars.username}";
    isNormalUser = true;
    extraGroups = [
      myvars.username
      "users"
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
