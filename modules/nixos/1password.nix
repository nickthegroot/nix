{
  myvars,
  ...
}:
{

  # Certain features, including CLI integration and system authentication support,
  # require enabling PolKit integration on some desktop environments (e.g. Plasma).
  programs._1password-gui.polkitPolicyOwners = [ myvars.username ];
  security.polkit.enable = true;
}
