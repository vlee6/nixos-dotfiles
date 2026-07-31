{
  pkgs,
  config,
  lib,
  ...
}: let
  # Helper functions for Lua code generation
  lua = lib.generators.mkLuaInline;
  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    center = lua ''hl.dsp.exec_cmd("centerwindow")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
  };

  # Helper constructors for hl.bind(key, handler, opts)
  bind = keys: dispatcher: {
    _args = [keys dispatcher];
  };
  bindOpts = keys: dispatcher: opts: {
    _args = [keys dispatcher opts];
  };

  # Theme options
  rounding = config.theme.rounding;
  gaps_in = config.theme.gaps_in;
  gaps_out = config.theme.gaps_out;
  active_border = config.theme.active_border;
  inactive_border = config.theme.inactive_border;
  active_opacity = config.theme.active_opacity;
  inactive_opacity = config.theme.inactive_opacity;
  dim_inactive = config.theme.dim_inactive;
  dim_strength = config.theme.dim_strength;
  shadow = config.theme.shadow;
  blur = config.theme.blur;
  border_size = config.theme.border_size;
  kb_layout = config.var.keyboardLayout;

  # Animation durations
  animationSpeed = config.theme.animation_speed;
  animationDuration =
    if animationSpeed == "slow"
    then "4"
    else if animationSpeed == "medium"
    then "2.5"
    else "1.5";
  borderDuration =
    if animationSpeed == "slow"
    then "10"
    else if animationSpeed == "medium"
    then "6"
    else "3";
  windowsOutDuration = lib.strings.floatToString ((builtins.fromJSON animationDuration) * 2);

  # Dynamic workspace keybindings 1..9
  workspaceBinds = lib.concatMap (i: let
    ws = toString i;
  in [
    (bind "SUPER + ${ws}" (dsp.focusWorkspace i))
    (bind "SUPER + SHIFT + ${ws}" (dsp.moveToWorkspace i))
  ]) (lib.range 1 9);
in {
  home.packages = with pkgs; [
    # Qt & Frameworks
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    hyprland-qtutils
    adw-gtk3
    wlr-randr
    wayland-utils
    wayland-protocols
    glib
    direnv
    meson
    gnome-themes-extra
    libva
    dconf
    imv

    # Utilities
    hyprshot
    hyprpicker
    hypridle
    hyprpolkitagent
    wf-recorder
    wl-clipboard

    # Media & Display
    swaybg
    brightnessctl
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    xwayland.enable = true;
    systemd = {
      enable = false;
      variables = ["--all"];
    };
    package = null;
    portalPackage = null;

    settings = {
      # Disable both exec-once and exec_once in settings
      exec-once = lib.mkForce null;
      exec_once = lib.mkForce null;

      monitor = [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "250x1080";
          scale = "1.25";
        }
        {
          output = "HDMI-A-1";
          mode = "1920x1080@75";
          position = "0x0";
          scale = "1";
        }
        {
          output = "DP-5";
          mode = "1920x1080@75";
          position = "0x0";
          scale = "1";
        }
        {
          output = "DP-6";
          mode = "1920x1080@75";
          position = "0x0";
          scale = "1";
        }
        {
          output = "DP-7";
          mode = "1920x1080@75";
          position = "0x0";
          scale = "1";
        }
        {
          output = "DP-2";
          mode = "1920x1080@60";
          position = "0x0";
          scale = "1";
          mirror = "eDP-1";
        }
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
        "ANKI_WAYLAND,1"
        "DISABLE_QT5_COMPAT,0"
        "NIXOS_OZONE_WL,1"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland,xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "__GL_GSYNC_ALLOWED,0"
        "__GL_VRR_ALLOWED,0"
        "DIRENV_LOG_FORMAT,"
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_BACKEND,vulkan"
        "WLR_RENDERER,vulkan"
        "WLR_NO_HARDWARE_CURSORS,1"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XCURSOR_SIZE,24"
      ];

      config = {
        general = {
          resize_on_border = true;
          gaps_in = gaps_in;
          gaps_out = gaps_out;
          border_size = border_size;
          layout = "master";
          col = {
            active_border = lib.mkForce active_border;
            inactive_border = lib.mkForce inactive_border;
          };
        };

        decoration = {
          active_opacity = active_opacity;
          inactive_opacity = inactive_opacity;
          dim_inactive = dim_inactive;
          dim_strength = dim_strength;
          rounding = rounding;
          shadow = {
            enabled = shadow;
            range = 20;
            render_power = 3;
          };
          blur = {
            enabled = blur;
            size = 18;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1"
          ];

          animation = [
            "windows, 1, ${animationDuration}, md3_decel, popin 60%"
            "windowsIn, 1, ${animationDuration}, md3_decel, popin 60%"
            "windowsOut, 1, ${windowsOutDuration}, md3_accel, popin 60%"
            "border, 1, ${borderDuration}, default"
            "fade, 1, ${animationDuration}, md3_decel"
            "layersIn, 1, ${animationDuration}, menu_decel, slide"
            "layersOut, 1, ${animationDuration}, menu_accel"
            "fadeLayersIn, 1, ${animationDuration}, menu_decel"
            "fadeLayersOut, 1, ${animationDuration}, menu_accel"
            "workspaces, 1, ${animationDuration}, menu_decel, slide"
            "specialWorkspace, 1, ${animationDuration}, md3_decel, slidevert"
          ];
        };

        master = {
          new_status = true;
          mfact = 0.5;
          new_on_top = false;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        misc = {
          force_default_wallpaper = 1;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = true;
        };

        input = {
          kb_layout = kb_layout;
          kb_options = "caps:escape_shifted_capslock";
          follow_mouse = 1;
          sensitivity = 0;
          accel_profile = "flat";

          touchpad = {
            scroll_factor = 0.35;
            natural_scroll = true;
            clickfinger_behavior = true;
          };
        };

        cursor = {
          no_hardware_cursors = true;
        };

        xwayland = {
          force_zero_scaling = true;
        };
      };

      bind =
        [
          # Essential binds
          (bind "SUPER + Q" (dsp.exec "ghostty --working-directory=~"))
          (bind "SUPER + F" (dsp.exec "thunar"))
          (bind "SUPER + SPACE" (dsp.exec "fuzzel"))

          (bind "SUPER + V" dsp.float)
          (bind "SUPER + J" dsp.center)
          (bind "SUPER + W" dsp.close)

          (bind "SUPER + L" (dsp.exec "hyprlock"))

          # Move focus
          (bind "SUPER + Left" (dsp.focus "l"))
          (bind "SUPER + Right" (dsp.focus "r"))
          (bind "SUPER + Up" (dsp.focus "r"))
          (bind "SUPER + Down" (dsp.focus "d"))

          # Special workspaces
          (bind "SUPER + S" (dsp.toggleSpecial "magic"))
          (bind "SUPER + CTRL + S" (dsp.moveToSpecial "magic"))

          # Switch monitor
          (bind "SUPER + SHIFT + MINUS" (dsp.exec "movecurrentworkspacetomonitor -1"))

          # Screenshot
          (bind "SUPER + SHIFT + S" (dsp.exec "hyprshot -m region --clipboard"))
          (bind "SUPER + CTRL + SHIFT + S" (dsp.exec "hyprshot -m region"))

          # Color picker
          (bind "SUPER + SHIFT + P" (dsp.exec "hyprpicker -a"))

          # Connect to bluetooth
          (bind "SUPER + B" (dsp.exec "bluetoothctl devices Paired | head -n 1 | awk '{print $2}' | xargs bluetoothctl connect"))
          (bind "SUPER + SHIFT + B" (dsp.exec "bluetoothctl devices Connected | awk '{print $2}' | xargs -I{} bluetoothctl disconnect {}"))

          # Workspace 10
          (bind "SUPER + 0" (dsp.focusWorkspace 10))
          (bind "SUPER + SHIFT + 0" (dsp.moveToWorkspace 10))

          # Mouse binds
          (bind "SUPER + mouse:272" dsp.drag)
          (bind "SUPER + mouse:273" dsp.resize)

          # Locked / Lid & Media keys
          (bindOpts ", switch:off:Lid Switch" (dsp.exec "hyprlock --immediate-render --no-fade-in") {locked = true;})
          (bindOpts ", switch:on:Lid Switch" (dsp.exec "hyprlock --immediate-render --no-fade-in") {locked = true;})

          (bindOpts ", XF86AudioNext" (dsp.exec "playerctl next") {locked = true;})
          (bindOpts ", XF86AudioPause" (dsp.exec "playerctl play-pause") {locked = true;})
          (bindOpts ", XF86AudioPlay" (dsp.exec "playerctl play-pause") {locked = true;})
          (bindOpts ", XF86AudioPrev" (dsp.exec "playerctl previous") {locked = true;})

          # Multimedia volume & brightness keys
          (bindOpts ", XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+") {
            locked = true;
            repeating = true;
          })
          (bindOpts ", XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-") {
            locked = true;
            repeating = true;
          })
          (bindOpts ", XF86AudioMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
            locked = true;
            repeating = true;
          })
          (bindOpts ", XF86AudioMicMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") {
            locked = true;
            repeating = true;
          })

          (bindOpts ", XF86MonBrightnessUp" (dsp.exec "brightnessctl -e4 -n2 set 2%+") {
            locked = true;
            repeating = true;
          })
          (bindOpts ", XF86MonBrightnessDown" (dsp.exec "brightnessctl -e4 -n2 set 2%-") {
            locked = true;
            repeating = true;
          })
        ]
        ++ workspaceBinds;

      windowrule = [
        "match:float true, no_dim on"
        "size 900 600, match:class ^(thunar)$, match:float 1"
        "center 1, match:class ^(thunar)$, match:float 1"
        "max_size 900 600, match:class ^(thunar)$, match:float 1"
      ];
    };

    extraConfig = ''
      hl.workspace("w[tv1]s[false]", { gapsout = 0, gapsin = 0 })
      hl.workspace("f[1]s[false]", { gapsout = 0, gapsin = 0 })
      hl.windowrule("border_size 0, match:float 0, match:workspace w[tv1]s[false]")
      hl.windowrule("rounding 0, match:float 0, match:workspace w[tv1]s[false]")
      hl.windowrule("border_size 0, match:float 0, match:workspace f[1]s[false]")
      hl.windowrule("rounding 0, match:float 0, match:workspace f[1]s[false]")

      hl.on("hyprland.start", function()
        hl.exec_cmd("systemctl --user enable --now hyprpaper.service")
        hl.exec_cmd("dbus-update-activation-environment --systemd --all &")
        hl.exec_cmd("waybar")
        hl.exec_cmd("hypridle")
        hl.exec_cmd("fcitx5 -d")
        hl.exec_cmd("systemctl --user start hyprpolkitagent")
      end)
    '';
  };
}
