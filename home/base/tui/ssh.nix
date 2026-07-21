{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = builtins.toFile "github.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEogUB/ZZmBiZbR2oPCPiF/FsXfTqCDk82BPJzexvODe Github Commit Key @nickthegroot";
      };
      "hf.co" = {
        IdentitiesOnly = true;
        IdentityFile = builtins.toFile "huggingface.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJm3PrKwQekk0y+9lMNk+w4LgN5rO2nG7T082dL4P7y HuggingFace @nickthegroot";
      };
    };
  };
}
