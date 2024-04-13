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
    nano.enable = false; # remove nano from building
    mtr.enable = true;
    #ssh = {
      #startAgent = true;
      #askPassword = "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    #};
  };
  

# Install packages sections 
  environment.systemPackages = with pkgs; [
  

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
    auto-cpufreq # Help battery life
  
    
    # security
    apparmor-utils 
    apparmor-profiles
    apparmor-bin-utils
    microcodeIntel
  ];

environment.defaultPackages = [  ]; 

   


 # Removing nixos manual from building
documentation.man.enable = false;
documentation.nixos.enable = false;


  systemd.extraConfig = "DefaultTimeoutStopSec=10s";


}
