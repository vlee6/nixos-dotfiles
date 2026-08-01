{
  pkgs,
  lib,
  config,
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

  lua = lib.generators.mkLuaInline;

  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.hypridle}/bin/hypridle &
    systemctl --user start hyprpolitagent &
  '';
in {
  imports = [
    ./animations.nix
    ./bindings.nix
  ];

  home.packages = with pkgs; [
    hyprshot
    hyprpicker
    hypridle
    hyprpolkitagent
    wf-recorder
    wl-clipboard

    brightnessctl
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    systemd.enable = false;

    settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1.25;
        }
      ];

      config = {
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

        misc = {
          force_default_wallpaper = 1;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = true;
        };

        general = {
          gaps_in = gaps_in;
          gaps_out = gaps_out;
          border_size = border_size;
          layout = "master";
          "col.active_border" = lib.mkForce active_border;
          "col.inactive_border" = lib.mkForce inactive_border;
        };

        decoration = {
          inherit rounding active_opacity inactive_opacity dim_strength;
          dim_inactive = dim_inactive;
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

        master = {
          new_status = "master";
          mfact = 0.5;
          new_on_top = false;
        };
      };

      on = {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("${startupScript}/bin/start")
            end'')
        ];
      };

      gesture = [
        {
          fingers = 3;
          direction = "vertical";
          action = "workspace";
        }
        {
          fingers = 3;
          direction = "left";
          action = lib.generators.mkLuaInline ''
            function()
              hl.dispatch(hl.dsp.send_shortcut({
                mods = "CTRL",
                key = "Page_Up",
                window = "active_window",
              }))
            end
          '';
        }
        {
          fingers = 3;
          direction = "right";
          action = lib.generators.mkLuaInline ''
            function()
              hl.dispatch(hl.dsp.send_shortcut({
                mods = "CTRL",
                key = "Page_Down",
                window = "active_window",
              }))
            end
          '';
        }
      ];
    };

    # Smart gaps
    extraConfig = ''
      hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
      hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
      hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0 })
      hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, rounding = 0 })
      hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0 })
      hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, rounding = 0 })
    '';
  };
}
