{
  # Anki currently broken on Darwin, see ../language-learning.nix for brew install

  programs.brave.extensions = [
    { id = "likgccmbimhjbgkjambclfkhldnlhbnn"; } # Yomitan (Popup Dictionary)
    { id = "hkledmpjpaehamkiehglnbelcpdflcab"; } # asbplayer (Text-Selectable Subtitles + Anki with Screenshots)
  ];
}
