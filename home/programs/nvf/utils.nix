{lib, ...}: {
  programs.nvf.settings.vim = {
    utility = {
      surround.enable = true;

      # Cache isn't being created?:
      leetcode-nvim = {
        enable = true;
        setupOpts = {
          lang = "cpp";
          image_support = true;
        };
      };

      images = {
        image-nvim = {
          enable = true;
          setupOpts = {
            backend = "kitty"; # Works natively with Ghostty
            processor = "magick_cli";
            integrations = {
              markdown = {
                enabled = true;
                download_remote_images = true;
                clear_in_insert_mode = false;
              };
            };
          };
        };
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
