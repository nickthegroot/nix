{
  myvars,
  pkgs,
  ...
}: {
  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${myvars.username}" = {
    home = "/Users/${myvars.username}";
  };
}
