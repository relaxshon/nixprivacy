{ config, lib, pkgs, ...}:

{



 #security.sudo = {
  #  enable = true;
   # extraConfig = "Defaults        env_reset,timestamp_timeout=30"; # Need to be moved to testing (if someone fail to enter the sudo password the timewait is defined for 30 min)
    #wheelNeedsPassword = false;
  #};


     #########setup user
 users.users.user = {
   createHome = true;
   home = "/home/user";
  initialPassword = "a";
  shell = pkgs.fish; # default shell for user
     isNormalUser = true;
    #extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     #packages = with pkgs; [
     #];
};


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # SSH SECTION
   programs.gnupg.agent = {
     enable = false;
     enableSSHSupport = false;
   };

   services.openssh.enable = false;

   ### SSH END

   ############### FIREWALL ################

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 80 443 ];
   networking.firewall.allowedUDPPorts = [ 53 ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;
   networking.firewall.allowPing = true;


    # enable apparmor and other security things..
  security.rtkit.enable = true;
  security.sudo.enable = false;
  security.apparmor.enable = true;
  security.protectKernelImage = lib.mkDefault true;
  #environment.memoryAllocator.provider = "graphene-hardened"; # i don't know if it a good idea to activate this need to be discussed
  #environment.defaultPackages = lib.mkForce []; # this command remove default package installed by nixos like perl , rsync etc..

  }

