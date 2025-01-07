#              .       '
#              : .ldOxXO0k,..
#           cl;OKXKKKKXKXXKXXl.';
#          .lKXKKXXXKKKXXXXXXXXk.
#          .0KXKxl:'....cKXXKXXXo.
#          ,XKko'........;KXXXXXl'
#            cdllc..';:l'..xc'Oc.
#             ;ccc.........:o0Xo
#               ;'.........,:K0
#                ,,.......,,ck,
#                 ;'...'co..:.
#                  ::,dxl;..,,
#                    'oo:...'. .
#                   ::;o..''.   .
#                ':c;:oo'.,.    .. ..
#            .;:cccclol:',.     .        .
#        ':::cccl;:;;,'':.      .           .
#        ccc;::;'......;,       ..          .
#        ;:;:;'...  ..';     ...,'...        .
#         ::c;,..   ..,'.....  ..;:,','..    .
#         .;:;'..   ...'.....  ..',:;',,,.    .
#        .,,''...     ....   ..  .';:,',,,.
#         ,''....      ...    .   .';;'','.   ..
#         .,'....      ...    .  .  .;:,'..   . .
#          c''....     ....  ..  x.  .;;,...   . .
#          c:'.. .     .'..  . ..l....'','..   . .
#          ::;..       .'... . ..........,'.   .. .
#          ,c:..    .  ..'.. . . .........:'.  ..  .
#          .c:,.     .  .'.... .     ...... .   .   .
#           c:;'        .'.... .     ..  .   .....   .
#           l:;'         ........   ...  .    .'''..  .
#           o;,'.        .'.'...      .  '     .,''''...
#          ,;;''.        .'.,...      .         ....'',...
#         ;;.....         ..'.....    .         ..........
#        ,'. .'..         .,'...        .      ..   .....'
#       ,'.  '....        .''...        .     .     ....,
#      ,... ;..  ..        .'....       .   ..      ....
#     ;... ;;               ,....       .  .       .....
#    ;'...;:..              .'..        ...        ..'.
#   ;....;:,........        '.'.        .  ..    .'',
#  '...':;c'.....        'c;''''.            .  .',,
# ....'c:::''..      .,;cxXXKo''..    .       .''',
# ;,,;c::ll,,'..',;:looodooxO0'''.    .      ..,,.
# ccc:cc:dxdoolllc:::c:::::oOX:....        ..,';
# lll:cccdl:;,;;,;;;;:;;:;::0Xx......    ...',,
# 'colllod:;;,,,,,;;;;;;:;::0XK.....   ...',,.,
#
# Main Desktop PC - RTX 3080, Ryzen 9 5900X
# https://pcpartpicker.com/user/nbd9/saved/#view=ZJBrmG
let
  hostName = "okabe-rintarou";
in {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix
    ./media-server.nix
  ];

  networking = {
    inherit hostName;

    networkmanager.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
