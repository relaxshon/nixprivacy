{ config, pkgs, lib, ... }: {

  nix = {
    settings.auto-optimise-store = true;
    extraOptions = "experimental-features = nix-command flakes";
    nixPath = ["nixpkgs=${pkgs.path}"];
  };

   nixpkgs.config.allowAliases = false;

  programs = {
   fish.enable = true;
    dconf.enable = true;
    nano.enable = false; # remove nano 
    mtr.enable = true;
    #ssh = {
      #startAgent = true;
      #askPassword = "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    #};
  };
  

# Install packages sections 
  environment.systemPackages = with pkgs; [

   #(pkgs.callPackage /mnt/etc/nixos/nixconf/m.nix { })

    # GUI
    bitwarden-desktop
    #gimp
    librewolf
    kitty
    stremio
    mullvad
    mullvad-vpn
    mullvad-browser
    #keepassxc
    #metadata-cleaner
    #libsForQt5.kleopatra

    # Comms

    # Player
    mpv # For watching twitch stream without being tracked by Twitch https://github.com/krathalan/wtwitch

    # Utils
    vim 
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
    microcodeIntel
  ];

environment.defaultPackages = [  ]; 

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

    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
        #autoLogin = { enable = true; user = "user"; };
      };
      desktopManager.gnome.enable = true;
      libinput = {
        enable = true;
        };
      };
    
      
#systemd.services."getty@tty1".enable = false;  # need to add this (as a workaround for autologin current (2023) 
#systemd.services."autovt@tty1".enable = false; # need to add this (as a workaround for autologin (2023)

 
#default editor micro
environment.variables.EDITOR = "gedit"; 
environment.variables.VISUAL = "vim";


   security.rtkit.enable = true;
   services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
};

hardware.pulseaudio.enable = false; # i repleace pulseaudio by pipewire 
   
   
   # Services section
services.printing.enable = false;
services.thermald.enable = true; # for battery
services.power-profiles-daemon.enable = false;
services.openssh.enable = false;
services.xserver.excludePackages = [ pkgs.xterm ];
services.mullvad-vpn.enable = true;


 # Removing nixos manual
documentation.man.enable = false;


  systemd.extraConfig = "DefaultTimeoutStopSec=10s";


}
