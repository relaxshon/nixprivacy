{ pkgs, config, ... }: { 

# https://nixos.wiki/wiki/Accelerated_Video_Playback

    home.file.".config/wofi/style.css".text = ''
      window {
  /* border: 2px solid red; */
  background-color: #1e222a;
  padding: 50px;
}

#input {
  padding: 10px 20px;
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  margin: 20px 15px;
}

#input:focus,
#input:selected,
#entry:selected,
#entry:focus {
  border-color: transparent;
}

#inner-box {
  margin: 20px;
}

#img {
  margin: 10px 10px;
}

#entry {
  border-radius: 20px;
}

#text:selected,
#img:selected {
  background-color: transparent;
}

#entry:selected {
  background-color: rgba(255, 255, 255, 0.1);
}
    '';
}

