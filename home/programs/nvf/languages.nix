{ lib, pkgs, ... }: {
  programs.nvf.settings.vim = {
    # Learn more about nvim diagnostics
    diagnostics = {
      nvim-lint = {
        enable = true;
      };
    };

    syntaxHighlighting = true;
    
    treesitter = {
      enable = true;
      autotagHtml = true;
      context.enable = true;
      highlight.enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        typescript
      ];
    };

    lsp = {
      enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
      lspconfig.enable = true;
      formatOnSave= true;
      inlayHints.enable = true;
      null-ls.enable = true;
      servers.nixd.settings.nil.nix.autoArchive = true;
      lspkind.enable = true;

      otter-nvim = {
        enable = true;
	setupOpts = {
          buffers.set_filetype = true;
	  lsp = {
            diagnostic_update_event = [
              "BufWritePost"
	      "InsertLeave"
	    ];
	  };
	};
      };
    };

    languages = {
      enableDap = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      bash.enable = true;

      clang.enable = true;
      assembly.enable = true;
      java.enable = true;
      python.eable = true;

      html.enable = true;
      css.enable = true;
      ts.enable = true;

      markdown = {
        enable = true;
	format.type = ["prettierd"];
	extensions = {
          markview-nvim = {
	    enable = true
	  };
	};
	extraDiagnostics.enable = true;
      };
    };

    formatter = {
      conform-nvim = {
        enable = true;
      };
    };

    autocomplete = {
      nvim-cmp.enable = true;
    };
  };
}
