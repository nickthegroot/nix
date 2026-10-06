{ pkgs, ... }:
let
  awscli2 = pkgs.awscli2.overrideAttrs (prevAttrs: {
    postInstall = prevAttrs.postInstall + ''
      cat > aws.fish <<EOF
      function __fish_aws_completer
          set -lx COMP_LINE (commandline -cp)
          set -lx COMP_POINT (string length -- (commandline -cp))
          $out/bin/aws_completer
      end
      complete -c aws -f -a '(__fish_aws_completer)'
      EOF

      installShellCompletion --cmd aws --fish aws.fish
    '';
  });
in
{
  home.packages = with pkgs; [
    awscli2
    ssm-session-manager-plugin
    hf
  ];
}
