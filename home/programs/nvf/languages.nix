{
  lib,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    # Learn more about nvim diagnostics
    diagnostics = {
      enable = true;
      config = {
        signs = {
          text = {
            "vim.diagnostic.severity.Error" = " ";
            "vim.diagnostic.severity.Warn" = " ";
            "vim.diagnostic.severity.Hint" = " ";
            "vim.diagnostic.severity.Info" = " ";
          };
        };

        underline = true;
        update_in_insert = true;
        virtual_text = {
          format =
            lib.generators.mkLuaInline
            /*
            lua
            */
            ''
              function(diagnostic)
                return string.format("%s", diagnostic.message)
                --return string.format("%s (%s)", diagnostic.message, diagnostic.source)
              end
            '';
        };
      };

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
      lspSignature.enable = false;
      lspconfig.enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      null-ls.enable = true;
      servers.nixd.settings.nil.nix.autoArchive = true;
      lspkind.enable = false;

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
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      bash.enable = true;

      clang.enable = true;
      assembly.enable = true;
      java.enable = true;
      python.enable = true;

      html.enable = true;
      css.enable = true;
      ts.enable = true;

      markdown = {
        enable = true;
        format.type = ["prettierd"];
        extensions = {
          markview-nvim = {
            enable = true;
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
      nvim-cmp.enable = false;
    };
  };
}
