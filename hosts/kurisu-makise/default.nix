#                     ........                            
#                  ..'',''';,',;.                         
#               .',,,''',;;;c::cc,.                       
#              .,;;:;;;;;;ccocc::,..                      
#             .:o:l:c:cll;:lx;;'....                      
#             .cd:lccl;;:'',,,'...''.                     
#             ',,,;:,;,',.,'.......'.                     
#             .....''..'.';,,....c,'.                     
#             ...',.''.:;0KK0,...c;'.                     
#             .'..kkk0OOKXXXXc''.;...                     
#              .  ;KXXXXXXXXXc'...''.                     
#              ..  'kXXKKKXXX;'..,,'..                    
#               . .. 'ckKXXxo.'.';,...                    
#               .....  ..l'od;'',;'....                   
#               ...... .'l,:d;'',,'......                 
#               ........c0c.:,',;,,. .....                
#             ..:lxKKo' ,c....,;,;,.;;;;;,.               
#            lllXXOKXXo....;o;.',,;,000KOKkok             
#           .cxoOxOXWWx,.;OXXk:'',;;k0KOxlod0.            
#          .ll:ldk000K:.c0NMMWO;...'o0Odllookk            
#          ,cx:lXMMWX0,.xWWWWWN0:...;xdc;lllx0k.          
#        .,ckdlWMMMMM0,'OWKkk0Oko,...d:,:cloddkx          
#         ..;;o0WWMMWo'cOXXWWXXNNdc..;',coc;clo.          
#        ',',.lO00KKK'.;xOKKKKXXOxx;.'.,llc,,':,          
#       'odl;,lK00KKO. ,kxx00KOxdkk:......;:coO0'         
#       ;Oddl',k0OO0l  :xOkkkxxkxxo.....,:::ldkk:         
#       :ddo,',c00Okl  ;0kOOOOOOOx'......;ooddddl,        
#       ;co:,',d00OOl. ,0NK00000kc'.....;;;oddxxod.       
#      .,;loc,;d00OO:  '0XMK00Oko.......,;:;:odolox       
#      ;,'cl:;lx00OO,  .KNMWOkOO;'''....,;::::coook;      
#     .;;,,:,lkkKWKO.  .KWNO0X0O''''..'':;::ldl:cdOk      
#     ',,',,:x0OOXW0   .OKkKWNK0,'.,..'';,:::oddodxk:     
#     ;:,,,;d0K0OOKx    dx0XXK00l..,,.',c;::ccldkkkxx.    
#    .,,,,,;OXNNKOk:   .dO0OO0KK0''',,.,xd,:clldkkOOkl    
#    ,,,;,;cxodk0Kkc  .lOOkkkxxO0x.';,,;k0c:ccodkOOOOO.   
#   .,,:c;;0MMocXXKOxoxo:oxxdok0KXk''',;O0k;c:cdkOOOOOl   
#   ;;;::,.cdx.cKNNKK0000MMMK,WMMMMc..''k0O:coc:oO00OOk.  
#  ';;;;;.        ..',;;.',;,.lllol...''d00x:ll:llk0OO0c  
# .;;:c:.   ..   ...  ...   ...      .''lOOk::clcc:lk00o. 
#
# Main Personal Laptop, 2021 M1 MacBook Pro
_:
let
  hostName = "kurisu-makise";
in {
  networking.hostName = hostName;
  networking.computerName = hostName;
  system.defaults.smb.NetBIOSName = hostName;
}
