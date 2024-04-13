{ config, pkgs, ... }:

{


 systemd.user.services.mullvadConfigure = {
    enable = true;
    description = "Configure Mullvad VPN settings";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "user"; # Replace with the actual username
      ExecStart = ''
        ${pkgs.mullvad}/bin/mullvad relay set tunnel-protocol wireguard
        ${pkgs.mullvad}/bin/mullvad obfuscation set mode udp2tcp
        ${pkgs.mullvad}/bin/mullvad tunnel set wireguard --quantum-resistant on
        ${pkgs.mullvad}/bin/mullvad relay set ownership owned
      '';
      RemainAfterExit = "yes";
    };
 };

}

