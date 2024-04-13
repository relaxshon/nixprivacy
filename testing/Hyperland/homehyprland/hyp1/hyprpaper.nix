{ pkgs, config, ... }: {

# Config wallpaper

    home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/user/wall.png
    wallpaper =,/home/user/wall.png
    '';
}

