{ pkgs, config, ... }: { 

# Waybar config sway

    home.file.".config/waybar/config.sway".text = ''
      	{
  "layer": "top",
    "position": "top",
    "modules-left": [
      "sway/workspaces",
      "sway/scratchpad",
      "sway/mode",
      "tray",
      "custom/updates"
      ],
    "modules-center": [
        "clock"
      ],
    "modules-right": [
      "network",
      "temperature",
      "memory",
      "cpu",
      "pulseaudio",
      "custom/powermenu",
    ],
    "tray": {
      "icon-size": 24,
    },
    "sway/scratchpad": {
        "format": "{icon} {count}",
        "show-empty": false,
        "format-icons": ["", ""],
        "tooltip": true,
        "tooltip-format": "{app}: {title}"
    },
    "sway/window": {
      "format": "<span style=\"italic\">{}</span>",
      "max-length": 50
    },
    "sway/workspaces": {
      "disable-scroll": true,
      "all-outputs": false,
      "format": "{icon} {name}",
      "format-icons": {
        "1": " ",
        "2": " ",
        "3": " ",
        "4": " ",
        "5": " ",
        "urgent": " ",
        "focused": " ",
        "default": " "
      }
    },
    "network": {
      "interface": "enp34s0",
      "tooltip-format-ethernet": "{ifname} ",
      "interval": 2,
      "format": " {bandwidthDownBits}  {bandwidthUpBits}",
    },
    "temperature": {
      "format": "{icon} {temperatureC}°C",
      "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
      "critical-threshold": 80,
      "format-icons": ["", "", ""]
    },
    "memory": {
      "format": " {}%",
      "tooltip": "false"
    },
    "cpu": {
      "format": " {usage}%",
      "tooltip": "false"
    },
    "custom/powermenu": {
      "format": "",
      "tooltip": false,
      "on-click": "exec $HOME/.config/rofi/powermenu.sh",
    },
    "custom/updates": {
      "format": " {}",
      "tooltip": false,
      "interval": 3600,
      "exec": "exec $HOME/.config/waybar/checkupdate.sh"
    },
    "pipewire": {
      "format": "{volume}% {icon}",
      "format-bluetooth": "{volume}% {icon}",
      "format-muted": "",
      "format-icons": {
          "headphone": "",
          "hands-free": "",
          "headset": "",
          "phone": "",
          "portable": "",
          "car": "",
          "default": ["", ""]
      },
      "scroll-step": 1,
      "on-click": "pavucontrol"
    },
    "clock": {
      //"format": "<span color=\"#56b6c2\"></span> {:%H:%M}",
      "format": "{:%H:%M}",
      "interval": 60
    }
}

    '';
}

