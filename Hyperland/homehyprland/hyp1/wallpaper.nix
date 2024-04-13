{ pkgs, config, ... }: { 

# https://nixos.wiki/wiki/Accelerated_Video_Playback

    home.file."wall.png" = {
      source = /mnt/etc/nixos/dot/wall.png;
};
}

