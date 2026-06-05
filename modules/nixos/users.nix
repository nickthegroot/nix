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
        "dialout"
      ];
    };

    groups = {
      "${myvars.username}" = { };
    };
  };
}
