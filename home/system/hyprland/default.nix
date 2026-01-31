{
  pkgs,
  config,
  lib,
  ...
}: let
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
in {
  imports = [
    ./animations.nix
    ./bindings.nix
    ./polkitagent.nix
  ];

  home.packages = with pkgs; [
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

    hyprshot
    hyprpicker
    hypridle
    wf-recorder
    wl-clipboard

    swaybg

    brightnessctl
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = false;
      variables = [
        "--all"
      ];
    };
    package = null;
    portalPackage = null;

    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd --all &"
        "waybar"
        "hypridle"
        "fcitx5 -d" # Chinese
      ];

      monitor = [
        "eDP-1, 1920x1080@60, 250x1080, 1.25"
        "HDMI-A-1, 1920x1080@75, 0x0, 1"
        "DP-5, 1920x1080@75, 0x0, 1"
        "DP-6, 1920x1080@75, 0x0, 1"
        "DP-7, 1920x1080@75, 0x0, 1"
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
        "DISABLE_QT5_COMPAT,0"
        "DIRENV_LOG_FORMAT,"
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_BACKEND,vulkan"
        "WLR_RENDERER,vulkan"
        "WLR_NO_HARDWARE_CURSORS,1"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XCURSOR_SIZE,24"
      ];

      cursor = {
        no_hardware_cursors = true;
      };

      general = {
        resize_on_border = true;
        gaps_in = gaps_in;
        gaps_out = gaps_out;
        border_size = border_size;
        layout = "master";
        "col.active_border" = lib.mkForce active_border;
        "col.inactive_border" = lib.mkForce inactive_border;
      };

      decoration = {
        active_opacity = active_opacity;
        inactive_opacity = inactive_opacity;
        dim_inactive =
          if dim_inactive
          then "true"
          else "false";
        dim_strength = dim_strength;
        rounding = rounding;
        shadow = {
          enabled =
            if shadow
            then "true"
            else "false";
          range = 20;
          render_power = 3;
        };
        blur = {
          enabled =
            if blur
            then "true"
            else "false";
          size = 18;
        };
      };

      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.5;
        new_on_top = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gesture = [
        "3, vertical, workspace"
        "3, left, dispatcher, sendshortcut, CTRL, Page_Up, active_window"
        "3, right, dispatcher, sendshortcut, CTRL, Page_Down, active_window"
      ];

      misc = {
        force_default_wallpaper = 1;
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
      };

      input = {
        kb_layout = kb_layout;
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          scroll_factor = 0.35;
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };

      xwayland = {
        force_zero_scaling = true;
      };
    };

    # Smart gaps
    extraConfig = ''
      workspace = w[tv1]s[false], gapsout:0, gapsin:0
      workspace = f[1]s[false], gapsout:0, gapsin:0
      windowrule = border_size 0, match:float 0, match:workspace w[tv1]s[false]
      windowrule = rounding 0, match:float 0, match:workspace w[tv1]s[false]
      windowrule = border_size 0, match:float 0, match:workspace f[1]s[false]
      windowrule = rounding 0, match:float 0, match:workspace f[1]s[false]
    '';
  };
}
