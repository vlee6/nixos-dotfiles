{ lib, ... }: {
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
  };
}
