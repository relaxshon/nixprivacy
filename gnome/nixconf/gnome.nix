 { config, lib, pkgs, ...}:

{
 
 environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-user-docs
    gnome-browser-connector
    gnome-console
    gnome-connections
    orca
    gnome-online-accounts
    snapshot # gnome camera package idk why they call this package snapshot...
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    evince # document viewer
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    baobab
    simple-scan # scanner 
    yelp
    gnome-remote-desktop
    pkgs.gnome-user-docs
    gnome-user-share
    gnome-shell-extensions
    gnome-online-miners
    gnome-characters
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-maps 
    gnome-logs
    gnome-weather
    gnome-font-viewer
    gnome-software
    gnome-contacts
    gnome-music
    #gnome-terminal # kitty is used as terminal it's better than gnome terminal
    file-roller
    seahorse
  ]);
  
  
   # improving gnome performance https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441  
  
  programs.evolution.enable = false; # gnome useless program to disable
  services.gnome.evolution-data-server.enable = lib.mkForce false; # removing shit gnome apps
  services.gnome.gnome-online-accounts.enable = lib.mkForce false; # removing shit gnome apps
  services.gnome.gnome-online-miners.enable = lib.mkForce false; # removing shit gnome apps
 services.gnome.tracker-miners.enable = lib.mkForce false; # removing shit gnome apps
  services.gnome.tracker.enable = lib.mkForce false; # removing shit gnome apps
  services.gnome.gnome-browser-connector.enable = lib.mkForce false; # removing shit gnome apps
  
  
  }
