{
  pkgs,
  lib,
  config,
  ...
}: let
  lua = lib.generators.mkLuaInline;

  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    center = lua ''hl.dsp.window.center()'';
    fullscreen = lua "hl.dsp.window.fullscreen()";
    pseudo = lua "hl.dsp.window.pseudo()";
    layout = msg: lua ''hl.dsp.layout("${msg}")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
    sendshortcut = mod: key: lua ''hl.dsp.send_shortcut({ mods = "${mod}", key = "${key}" })'';
  };

  bind = keys: dispatcher: {_args = [keys dispatcher];};
  bindOpts = keys: dispatcher: opts: {_args = [keys dispatcher opts];};

  workspaceBinds = lib.concatMap (
    i: let
      key = toString (lib.mod i 10);
    in [
      (bind "SUPER + ${key}" (dsp.focusWorkspace i))
      (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
    ]
  ) (lib.range 1 10);
in {
  wayland.windowManager.hyprland = {
    settings = {
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
          (bindOpts "SUPER + mouse:272" dsp.drag {mouse = true;})
          (bindOpts "SUPER + mouse:273" dsp.resize {mouse = true;})

          # Multimedia volume & brightness keys (bindel)
          (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+") {
            locked = true;
            repeat = true;
          })
          (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-") {
            locked = true;
            repeat = true;
          })
          (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
            locked = true;
            repeat = true;
          })
          (bindOpts "XF86AudioMicMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") {
            locked = true;
            repeat = true;
          })

          (bindOpts "XF86MonBrightnessUp" (dsp.exec "brightnessctl -e4 -n2 set 2%+") {
            locked = true;
            repeat = true;
          })
          (bindOpts "XF86MonBrightnessDown" (dsp.exec "brightnessctl -e4 -n2 set 2%-") {
            locked = true;
            repeat = true;
          })
        ]
        ++ workspaceBinds;
    };
  };
}
