{ pkgs, config, ... }: { 

# https://nixos.wiki/wiki/Accelerated_Video_Playback

    home.file.".config/mpv/mpv.conf".text = ''
      	hwdec=auto-safe
	vo=gpu
	profile=gpu-hq
	gpu-context=wayland
    '';
}

