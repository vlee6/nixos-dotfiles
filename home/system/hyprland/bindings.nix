{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bind =
      [
        # Essential binds
        "$mainMod, Q, exec, ghostty --working-directory=~"
        "$mainMod, F, exec, ghostty -e yazi"
        "$mainMod, SPACE, exec, fuzzel"

        "$mainMod, V, togglefloating"
        "$mainMod, J, togglesplit"
        "$mainMod, W, killactive"

        "$mainMod, L, exec, hyprlock"

        # Move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, r"
        "$mainMod, down, movefocus, d"

        # Special workspaces
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod CTRL, S, movetoworkspace, special:magic"

        # Switch monitor
        "$mainMod SHIFT, MINUS, movecurrentworkspacetomonitor, -1"

        # Screenshot
        "$mainMod SHIFT, S, exec, hyprshot -m region --clipboard"
        "$mainMod CTRL SHIFT, S, exec, hyprshot -m region"

        # Color picker
        "$mainMod, P, exec, hyprpicker -a"

        # Connect to bluetooh
        "$mainMod, B, exec, bluetoothctl devices Paired | head -n 1 | awk '{print $2}' | xargs bluetoothctl connect"
        "$mainMod SHIFT, B, exec, bluetoothctl devices Connected | awk '{print $2}' | xargs -I{} bluetoothctl disconnect {}"

        # Workspace 10
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ]
      ++ (builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          "$mainMod,code:1${toString i}, workspace, ${toString ws}"
          "$mainMod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
        ])
        9));

    # Lid and media input
    bindl = [
      # Locking
      ", switch:off:Lid Switch, exec, hyprlock --immediate-render --no-fade-in"
      ", switch:on:Lid Switch, exec, hyprlock --immediate-render --no-fade-in"

      # Media controls
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    # Laptop multimedia keys
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 2%+"
      ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 2%-"
    ];

    # Mouse
    bindm = [
      # Move and resize
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
