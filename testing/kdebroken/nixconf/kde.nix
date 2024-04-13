 { config, lib, pkgs, ...}:

{
 
 environment.plasma6.excludePackages = with pkgs.kdePackages; [
  plasma-browser-integration
  konsole
  print-manager # added
  khelpcenter # added
  kwalletmanager # added
  oxygen
  elisa
  kmines
  klines
  kiriki
  kapman
  kamoso
  kamera
  kalarm
  dragon
  cantor
  falkon
  bomber
  tokodon
  kwallet # added
  kturtle
  kshisen
  kpkpass
  kpeople
  kblocks
];

 services.desktopManager.plasma6.enable = true;
  
  }
