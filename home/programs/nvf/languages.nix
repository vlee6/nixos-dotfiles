{
  lib,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    # TODO: Learn more about nvim diagnostics
    diagnostics = {
      enable = true;
      config = {
        severity = {
          min = lib.generators.mkLuaInline "vim.diagnostic.severity.ERROR";
        };

        signs = {
          text = lib.generators.mkLuaInline ''
            {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.HINT]  = " ",
              [vim.diagnostic.severity.INFO]  = " ",
            }
          '';
        };

        virtual_text = {
          severity = {
            min = lib.generators.mkLuaInline "vim.diagnostic.severity.ERROR";
          };

          format = lib.generators.mkLuaInline ''
            function(diagnostic)
              return string.format("%s", diagnostic.message)
            end
          '';
        };

        underline = {
          severity = {
            min = lib.generators.mkLuaInline "vim.diagnostic.severity.ERROR";
          };
        };
        update_in_insert = true;
      };

      nvim-lint.enable = true;
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
