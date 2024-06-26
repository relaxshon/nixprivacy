{ pkgs, config, ... }: { 

# https://nixos.wiki/wiki/Accelerated_Video_Playback

    home.file.".config/hypr/hyprland.conf".text = ''
#
# Please note not all available settings / options are set here.

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=,preferred,auto,auto


# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
exec-once = waybar & nm-applet
exec-once = swww-daemon & swww img /home/user/wall.png
exec-once = brightnessctl s 10%
exec-once = mullvad relay set tunnel-protocol wireguard & mullvad obfuscation set mode udp2tcp & mullvad tunnel set wireguard --quantum-resistant on & mullvad relay set ownership 'owned'


# Source a file (multi-file configs)
# source = ~/.config/hypr/myColors.conf

# Set programs that you use
$terminal = kitty
$fileManager = thunar
$menu = wofi --show drun
$password = bitwarden
$mul = mullvad-browser
$wolf = librewolf
$stremio = stremio
$killswitch = mullvad lockdown-mode set 'on'

# Some default env vars.
env = GDK_BACKEND=wayland
env = QT_QPA_PLATFORM,wayland
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = QT_QPA_PLATFORM,wayland;xcb
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
env = QT_QPA_PLATFORMTHEME,qt5ct
env = GTK_THEME,Sweet-Dark
env = XCURSOR_THEME,"Capitaine Cursors"
env = XCURSOR_SIZE,24

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = false
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    cursor_inactive_timeout = 1

    gaps_in = 5
    gaps_out = 0
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 5

screen_shader = /home/user/.config/hypr/shaders.frag

    #blur {
        #enabled = true
        #size = 3
        #passes = 1
        
        #vibrancy = 0.1696
    #}

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = true

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    
  bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 5, myBezier
    animation = windowsOut, 1, 5, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 5, default
    animation = specialWorkspace, 1, 5, myBezier, slidevert
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = true
    workspace_swipe_fingers = 3
}

misc {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    force_default_wallpaper = -0 # Set to 0 or 1 to disable the anime mascot wallpapers
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

# Example windowrule v1
windowrulev2 = float,class:^(Lxappearance)$
windowrulev2 = opacity 0.8 0.8,title:^(rofi)(.*)$
windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
windowrulev2 = opacity 0.8 0.8,class:^(wofi)$
windowrulev2 = maximize,title:^(nvim)$
windowrulev2 = float,title:^(ranger)$
windowrulev2 = size 60% 80%,title:^(Open Files|ranger)$
windowrulev2 = opacity 0.8 0.8,title:^(Open Files|ranger)$
windowrulev2 = opacity 1 1,class:^(kitty)$,title:^(nvim)(.*)$ # disable opacity while opening neovim
windowrulev2 = noborder,fullscreen:1 # remove border on fullscreen
layerrule = blur,gtk-layer-shell

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Q, exec, $terminal # kitty
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit, 
bind = $mainMod, D, exec, $killswitch 
bind = $mainMod, B, exec, $password # bitwarden
bind = $mainMod, X, exec, $mul # mullvad browser
bind = $mainMod, W, exec, $wolf # librewolf
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating,
bind = $mainMod, A, exec, $menu 
bind = $mainMod, F, exec, fullscreen
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, Z, exec, $stremio # stremio
bind = ALT, Q, exec, shutdown -h 0 # shutdown system fast
bind = $mainMod, T, exec, kitty -e fish -c 'git clone https://github.com/krathalan/wtwitch; fish_add_path wtwitch/src; wtwitch p mpv; wtwitch q 1080p60,720p60,720p; wtwitch t; fish'

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10
bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
bind = $mainMod, F9, exec, wlsunset -T 6500
bind = $mainMod, F10, exec, pkill wlsunset

# Screenshots
# Screenshot a window
bind = $mainMod, PRINT, exec, hyprshot -m window
# Screenshot a monitor
bind = , PRINT, exec, hyprshot -m output
# Screenshot a region
bind = $shiftMod, PRINT, exec, hyprshot -m region

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

    '';
}

