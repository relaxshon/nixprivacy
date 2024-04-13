{ pkgs, config, ...}:

{

imports =
    [ 
    ./home
    ];
    

    home.username = "user"; #replace user by your username !
    home.homeDirectory = "/home/user"; # replace user by your username !
    home.enableNixpkgsReleaseCheck = false;
    home.stateVersion = "24.05"; # To figure this out you can comment out the line and see what version it expected.
 
    programs.home-manager.enable = true;
    #dconf.settings = {                                   # enable gnome tap to click and dark theme by default on boot 
  #};
}

