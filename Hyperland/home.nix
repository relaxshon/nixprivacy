{ pkgs, config, ...}:

{

imports =
    [ 
    ./homehyprland
    ];
    
    
    
    home.username = "user"; #replace user by your username !
    home.homeDirectory = "/home/user"; # replace user by your username !
    home.enableNixpkgsReleaseCheck = false;  
    home.stateVersion = "23.11"; # To figure this out you can comment out the line and see what version it expected.
 
programs.home-manager.enable = true;
 
  wayland.windowManager.hyprland = {
    systemd.enable = true;
  };
 
 
#home.file.".config" = {
 #     source = /mnt/home/user/dotfiles/.config;
  #    recursive = true;
   #   };
    #  home.file.".local" = {
     # source = /mnt/home/user/dotfiles/.local;
      #recursive = true;
      #};
      #home.file.".screenshots" = {
      #source = /mnt/home/user/dotfiles/.screenshots;
      #recursive = true;
      #};
      #home.file.".wallpapers" = {
      #source = /mnt/home/user/dotfiles/.wallpapers;
      #recursive = true;
      #};
}

