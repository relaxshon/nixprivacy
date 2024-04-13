# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ...}:

{
  imports =
    [ # Hardware-configuration.nix is in the file default.nix no worry
    ];
  

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
   };
   
  
   
   #########setup user
 users.users.user = {
   createHome = true;
   home = "/home/user"; 
  initialPassword = "a";
  shell = pkgs.fish; # default shell for user
     isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     #packages = with pkgs; [
     #];
};
#users.defaultUserShell = pkgs.fish;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.gnupg.agent = {
     enable = false;
     enableSSHSupport = false;
   };



   
############### SECURITY ################

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 80 443 ];
   networking.firewall.allowedUDPPorts = [ 53 ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;
   networking.firewall.allowPing = false;
   
   ### GMT Timezone like tails
     time.timeZone = "Europe/Iceland";
   
   
   
   nixpkgs.overlays = [
  (final: prev: {
    gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
      mutter = gnomePrev.mutter.overrideAttrs ( old: {
        src = pkgs.fetchgit {
          url = "https://gitlab.gnome.org/vanvugt/mutter.git";
          # GNOME 45: triple-buffering-v4-45
          rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
          sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
        };
      } );
    });
  })
];

  
  
  # enable apparmor and other security things..
  security.sudo.enable = true;
  security.apparmor.enable = true;
  security.protectKernelImage = lib.mkDefault true;
  #environment.memoryAllocator.provider = "graphene-hardened"; # i don't know if it a good idea to activate this need to be discussed
  #environment.defaultPackages = lib.mkForce []; # this command remove default package installed by nixos like perl , rsync etc..


  ### DNS ###

 services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv4_servers = true;
      require_dnssec = true;
      require_nolog = true;
      doh_servers = true;
      ipv6_servers = false;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md
       server_names = [ "mullvad-extend-doh" ];
    };
  };
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };



  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # flake ask to disable this > system.copySystemConfiguration = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  # Did you read the comment?
  system.stateVersion = "24.05";
}

