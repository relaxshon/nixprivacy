{ pkgs, config, ... }: {

# Config kitty

    home.file.".config/kitty/kitty.conf".text = ''
      map ctrl+c copy_to_clipboard
      map ctrl+v paste_from_clipboard
      confirm_os_window_close 2
       copy_on_select on
    '';
}

