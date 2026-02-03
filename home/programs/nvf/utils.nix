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
        setupOpts.custom_colorcolumn = {
          nix = "110";
          cpp = "110";
          python = "110";
        };
      };
    };

    filetree.nvimTree = {
      enable = true;
      openOnSetup = false;
      setupOpts = {
        hijack_netrw = false;
        hijack_directories.enable = false;
        update_focused_file = {
          enable = true;
          update_root = true;
        };
        renderer = {
          group_empty = true;
        };
        filters = {
          dotfiles = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
        mode = "n";
        silent = true;
        desc = "Toggle nvim-tree";
      }
      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
        desc = "Move to left split (the tree)";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
        desc = "Move to right split (the code)";
      }
    ];
  };
}
