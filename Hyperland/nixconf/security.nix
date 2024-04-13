 security.sudo = {
    enable = true;
    extraConfig = "Defaults        env_reset,timestamp_timeout=30";
    wheelNeedsPassword = false;
  };
  
 services.dbus.apparmor = "enabled";
