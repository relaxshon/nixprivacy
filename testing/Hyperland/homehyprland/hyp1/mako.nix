{ pkgs, config, ... }: { 

# https://nixos.wiki/wiki/Accelerated_Video_Playback

    home.file.".config/mako/config".text = ''
font="Lucida Grande 10"
#background-color=#303643
#text-color=#f7f8f9
#border-size=0
#border-radius=#12px
progress-color=#fa5aa4
sort=-time
layer=overlay
background-color=#383f4e
text-color=#f7f8f9
border-size=0
border-radius=12
max-icon-size=64
default-timeout=5000
ignore-timeout=1

[urgency=low]
#border-color=#cccccc

[urgency=normal]
#border-color=#d08770

[urgency=high]
#border-color=#bf616a
default-timeout=0

[category=mpd]
default-timeout=2000
group-by=category
    '';
}

