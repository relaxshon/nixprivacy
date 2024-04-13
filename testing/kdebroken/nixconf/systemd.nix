{ config, pkgs, ... }:

{
 # Define the custom systemd service
 systemd.services.mullvadconf = {
    description = "Config mullvad";
    after = [ "network.target" ]; # Ensure the service starts after the network is up
    wantedBy = [ "multi-user.target" ]; # Ensure the service is started at boot

    serviceConfig = {
      Type = "simple"; # Specify the service type
      User = "user"; # Specify the user under which the service should run
      ExecStartPre = [
        "${pkgs.mullvad}/bin/mullvad relay set tunnel-protocol wireguard"
        "${pkgs.mullvad}/bin/mullvad obfuscation set mode udp2tcp"
        "${pkgs.mullvad}/bin/mullvad tunnel set wireguard --quantum-resistant on"
        "${pkgs.mullvad}/bin/mullvad relay set ownership owned"
      ];
      ExecStart = "${pkgs.mullvad}/bin/mullvad api-access enable 2"; # Specify the main command to execute
      ExecStartPost = "${pkgs.mullvad}/bin/mullvad api-access disable 1"; # Specify a command to run after the main command
      Restart = "always"; # Ensure the service is restarted if it fails
    };
 };
 
 }


 # Define the custom systemd service
 systemd.user.services.clipboardMonitor = {
    description = "Clipboard Monitor";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.writeShellScript "clipboard-monitor" ''
        #!/bin/sh
        while true; do
          sleep 0.5s
          if [ -n "$(qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardContents)" ]; then
            if [ "$CONTENTS" != "$(qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardContents)" ]; then
              counter=0
            fi

            if [ $counter -ge 39 ]; then
              qdbus org.kde.klipper /klipper org.kde.klipper.klipper.clearClipboardHistory
              unset CONTENTS
              counter=0
            fi

            counter=$((counter + 1))
            CONTENTS=$(qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardContents)
          fi
        done
      ''}/bin/clipboard-monitor";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
 };
}



}

