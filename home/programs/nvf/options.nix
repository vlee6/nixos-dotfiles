{lib, ...}: {
  programs.nvf.settings.vim = {
    globals = {
      mapleader = " ";
      netrw_list_hide = "^\\..*";
      netrw_hide = 1;
      netrw_banner = 0;
    };

    viAlias = true;
    vimAlias = true;
    withNodeJs = true;

    options = {
      autoindent = true;
      smartindent = true;
      shiftwidth = 2;
      wrap = false;
    };

    globals = {
      navic_silence = true;
      suda_smart_edit = 1;
    };

    clipboard = {
      enable = true;
      registers = "unnamedplus";
      providers.wl-copy.enable = true;
    };
  };
}
