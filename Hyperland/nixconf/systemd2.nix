{ config, pkgs, ... }:

let
  systemdServices = {
    mullvad-service = {
     enable = true;
      description = "Mullvad Network Configuration";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "user";
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.mullvad}/bin/mullvad relay set tunnel-protocol wireguard
          ${pkgs.mullvad}/bin/mullvad obfuscation set mode udp2tcp
          ${pkgs.mullvad}/bin/mullvad tunnel set wireguard --quantum-resistant on
          ${pkgs.mullvad}/bin/mullvad relay set ownership owned
        '';
        # Run this service after the network is up
        After = [ "network.target" ];
        # Retry if it fails
        Restart = "on-failure";
      };
    };
  };
in
{
  systemd.services = systemdServices;
}

