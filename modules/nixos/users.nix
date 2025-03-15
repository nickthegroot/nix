{ myvars, ... }:
{
  users = {
    users."${myvars.username}" = {
      home = "/home/${myvars.username}";
      isNormalUser = true;

      extraGroups = [
        myvars.username
        "users"
        "networkmanager"
        "wheel"
      ];
    };

    groups = {
      "${myvars.username}" = { };
    };
  };
}
