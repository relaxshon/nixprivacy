{ pkgs, config, ... }: { 

# https://nixos.wiki/wiki/Accelerated_Video_Playback

    home.file.".config/wofi/config".text = ''
show=drun
width=40%
height=60%
prompt=Search...
normal_window=true
location=center
gtk-dark=true
allow_images=true
image_size=48
insensitive=true
allow_markup=true
no_actions=true
orientation=vertical
halign=fill
content_halign=fill
    '';
}

