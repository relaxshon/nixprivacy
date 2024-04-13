# NetworkManager
{ config, pkgs, lib, ... }: {
  options.network-manager = {
    connections = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
    };
  };

  config = {
    networking.useDHCP = false;
    networking.nameservers  = [  "127.0.0.1" "::1" ];
    networking.networkmanager = {
      dns = "none";
      enable = true;
      wifi = {
        powersave = true;
        scanRandMacAddress = true;
        # XXX https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1091
        #backend = "iwd";
        # Generate a random MAC for each WiFi and associate the two permanently.
        macAddress = "stable";
      };
      # Randomize MAC for every ethernet connetion
      ethernet.macAddress = "random";
      connectionConfig = {
        # IPv6 Privacy Extensions
        "ipv6.ip6-privacy" = 2;

        # unique DUID per connection
        "ipv6.dhcp-duid" = "stable-uuid";
      };
    };        
        ####### this option remove remove building and install useless plugins vpn from networkmanager
   networking.networkmanager.plugins = lib.mkForce [];

    users.users.user.extraGroups = [
      "networkmanager"
    ];
     
    networking.hostName = "user";
  };
}
