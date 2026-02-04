{lib, ...}: {
  programs.nvf.settings.vim = {
    utility = {
      surround.enable = true;
      leetcode-nvim.enable = true;

      motion = {
        leap.enable = true;
      };
    };

    notes = {
      todo-comments.enable = true;
    };

    ui = {
      borders.enable = true;
      colorizer.enable = true;

      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };
      smartcolumn = {
        enable = true;
        setupOpts = {
          disabled_filetypes = ["neo-tree" "help" "text" "markdown"];
          custom_colorcolumn = {
            nix = "110";
            cpp = "110";
            python = "110";
          };
        };
      };
    };

    statusline.lualine.enable = true;

    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        enable_git_status = false;
        filesystem = {
          hijack_netrw_behavior = "open_default";
        };
        window = {
          width = 30;
        };
        update_focused_file = {
          enable = true;
          update_root = true;
        };
        renderer = {
          group_empty = true;
          text_fader = false;
        };
        filters = {
          dotfiles = true;
        };
      };
    };

    terminal.toggleterm.enable = true;
  };
}
