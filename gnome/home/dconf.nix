{ pkgs, config, lib, ...}:

{



 dconf.settings = {
     "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        click-method = "default";
        two-finger-scrolling-enabled = true;
        natural-scroll = true;
        };
        "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = true;
        };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/settings-daemon/plugins/color" = {
    night-light-enabled = true;
    };
    "org/gnome/desktop/privacy" = {
    disable-camera = "true";
    };
    "org/gnome/TextEditor" = {
    style-scheme = "classic-dark";
    };
    "org/gnome/TextEditor" = {
    style-variant = "dark";
    };
    #"/org/gnome/TextEditor" = {
    #show-grid = true;
    #};
    #"/org/gnome/TextEditor" = {
    #show-map = true;
    #};
    "org/gnome/desktop/background" = {
# picture-uri='file:///usr/share/tails/desktop_wallpaper.png' I comment this because i need to decide which background we will choose
    disable-log-out = true;
    disable-user-switching = true;
    };
    "org/gnome/desktop/media-handling" = {
    automount = "true";
    automount-open = "false";
  };
    "org/gnome/desktop/privacy" = {
    usb-protection = true;
    usb-protection-level = "lockscreen";
  };
    "org/gnome/desktop/screensaver" = {
    lock-enabled = true;
    user-switch-enabled = false;
  };
"org/gnome/desktop/search-providers" = {
disabled = ["org.gnome.Calculator.desktop org.gnome.Contacts.desktop org.gnome.Documents.desktop org.gnome.Nautilus.desktop org.gnome.Terminal.desktop"];
  };
"org/gnome/desktop/sound" = {
event-sounds = false;
allow-volume-above-100-percent = true;
  };
"org/gnome/desktop/wm/preferences" = {
button-layout = "appmenu:minimize,maximize,close";
  };
"org/gnome/nautilus/desktop" = {
volumes-visible = false;
  };
"org/gnome/nautilus/icon-view" = {
default-zoom-level = "small";
  };
"org/gnome/settings-daemon/plugins/power" = {
power-button-action = "nothing";
lid-close-ac-action = "blank";
lid-close-battery-action = "blank";
sleep-inactive-ac-type = "nothing";
sleep-inactive-battery-type = "nothing";
  };
"org/gnome/system/location" = {
enabled = false;
  };
"org/gnome/shell" = {
      favorite-apps = [
        "librewolf.desktop"
        "mullvad-vpn.desktop"
        "stremio.desktop"
        "kitty.desktop"
        "nautilus.desktop"
        "mullvad-browser.desktop"
        "bitwarden.desktop"
        "kleopatra.desktop"
      ];
    };
"org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [ (lib.gvariant.mkTuple [ "xkb" "us" ]) (lib.gvariant.mkTuple [ "xkb" "fr" ])  (lib.gvariant.mkTuple [ "xkb" "es" ]) (lib.gvariant.mkTuple [ "xkb" "it" ]) (lib.gvariant.mkTuple [ "xkb" "ru" ]) (lib.gvariant.mkTuple [ "ibus" "libpinyin" ]) (lib.gvariant.mkTuple [ "ibus" "mozc-jp" ]) (lib.gvariant.mkTuple [ "ibus" "hangul" ]) (lib.gvariant.mkTuple [ "ibus" "Unikey" ]) (lib.gvariant.mkTuple [ "ibus" "chewing" ]) ];
 };
 "org/gnome/desktop/a11y" = {
  always-show-universal-access-status = true;
  };
"org/gnome/desktop/interface" = {
enable-animations = true;
  };
  #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding" = "<Alt>q";
  #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command" = "shutdown -h 0";
  #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name" = "Shutdown";
  #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings" = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
  };

}
