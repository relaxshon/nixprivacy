{ config, pkgs, ... }:

{


 systemd.services.mullvadConfigure = {
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



 systemd.user.services.clipboard-cleaner = {
    enable = true;
    description = "Clipboard Cleaner";
    wantedBy = [ "multi-user.target" ];
    script = ''
    #!${pkgs.bash}/bin/bash
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
    '';
    serviceConfig = {
      Restart = "always";
      User = "user";
      RestartSec = "5s";
      StartLimitIntervalSec = 0;
    };
 };


}

