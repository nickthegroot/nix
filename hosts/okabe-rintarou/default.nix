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
{
  name = "okabe-rintarou";
  nixos-modules = [
    ./hardware-configuration.nix
    ./hardware-nvidia.nix
    ./rgb.nix
    {
      modules.ssh.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFx8ntzpKZXxqDl+wHSo64qySAetdZeNolJ8I7Hm6KWq";
    }
  ];
  home-modules = [
    ./home.nix
  ];
}
