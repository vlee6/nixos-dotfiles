{ pkgs, config, ... }: {
  programs.waybar.style =
    let
      fg = config.lib.stylix.colors.base05;
      bg = config.lib.stylix.colors.base00;
    in ''
    * {
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 12px;
      font-weight: bold;
      box-shadow: none;
      text-shadow: none;
      transition: none;
      border-radius: 0px;
      border: 0px;
    }
    
    window#waybar {
      background-color: @bg;
    }
    
    #workspaces button {
      padding: 0 6px;
      background: transparent;
      color: #${fg};
    }
    
    #workspaces button.active {
      background: #${fg};
      color: #${bg};
    }
    
    button:hover {
      box-shadow: inset 0 2px 0 0 @white;
    }
    
    #clock,
    #cpu,
    #memory,
    #battery,
    #network,
    #pulseaudio {
      padding: 0 8px;
      color: #${fg};
    }
    '';
}
