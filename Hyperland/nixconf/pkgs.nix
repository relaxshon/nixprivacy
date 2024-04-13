{ config, pkgs, inputs, ... }: {

  nix = {
    settings.auto-optimise-store = true;
    extraOptions = "experimental-features = nix-command flakes";
    nixPath = ["nixpkgs=${pkgs.path}"];
  };

   
  programs = {
    thunar.enable = true;
    fish.enable = true;
    hyprland.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;
    nano.enable = false; # remove nano 
    mtr.enable = true;
    #ssh = {
      #startAgent = true;
      #askPassword = "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    #};
  };


# Install packages sections 
  environment.systemPackages = with pkgs; [

  (pkgs.callPackage /mnt/etc/nixos/nixconf/m.nix { })

    # GUI
    #bitwarden-desktop
    #gimp
    librewolf
    kitty
    stremio
    mullvad-browser
    #keepassxc
    #metadata-cleaner
    #mullvad
    #mullvad-vpn
    #libsForQt5.kleopatra

    #Hyperland
    #ranger 
    sweet
    #swaylock-effects
    capitaine-cursors
    wofi
    waybar
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    wlogout  
    xdg-desktop-portal-hyprland
    hyprland 
    hyprshade
    
    
    #edit
    gnome-text-editor
    
    # wallpaper
    #grim
    #slurp
    #swww
    hyprpaper
    
    # screenshot
    #hyprshot
    
    
    
    # Hyprland wiki say to install this
    #bemenu
    #fuzzel
    #tofi


    # network applet
    networkmanagerapplet
    
    #light
    brightnessctl
    
    #sound
   pavucontrol

    # Notif
    mako

    # Player
    mpv # For watching twitch stream without being tracked by Twitch https://github.com/krathalan/wtwitch

    # Utils
    curl # For watching twitch stream without being tracked by Twitch https://github.com/krathalan/wtwitch
    git
    jq # For watching twitch stream without being tracked by Twitch https://github.com/krathalan/wtwitch
    wget
    streamlink # For watching twitch stream without being tracked by Twitch https://github.com/krathalan/wtwitch
    auto-cpufreq # Save battery life 
    
    # security
    apparmor-utils 
    apparmor-profiles
    apparmor-bin-utils
  ];


fonts.packages = with pkgs; [
 hackgen-nf-font
];

environment.defaultPackages = [  ]; 



#default editor neovim
environment.variables.EDITOR = "nvim"; 
environment.variables.VISUAL = "nvim";



 ##### POWERSAVING for laptop
services.auto-cpufreq.enable = true;
services.auto-cpufreq.settings = {
  battery = {
     governor = "powersave";
     turbo = "never";
  };
  charger = {
     governor = "performance";
     turbo = "auto";
  };
};

 

   security.rtkit.enable = true;

   
   # Services section
services.printing.enable = false;
services.thermald.enable = true; # for battery
services.power-profiles-daemon.enable = false;
services.openssh.enable = false;
services.xserver.excludePackages = [ pkgs.xterm ];
services.mullvad-vpn.enable = true;
services.gvfs.enable = true; # Mount, trash, and other functionalities Thunar file manager


 # Removing nixos manual
documentation.man.enable = false;
documentation.nixos.enable = false;

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}

