{...}: {
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
        mode = "n";
        silent = true;
        desc = "Toggle neotree";
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
      {
        key = "<leader>t";
        mode = "n";
        action = ":ToggleTerm dir=%:p:h direction=float<CR>";
        silent = true;
        desc = "Toggle floating terminal";
      }
      {
        key = "<leader>n";
        mode = "n";
        action = ":Navbuddy<CR>";
        silent = true;
        desc = "Open navbuddy";
      }
      {
        key = "<Up>";
        action = "<Nop>";
        mode = "i";
        desc = "Disable Up arrow in insert mode";
      }
      {
        key = "<Down>";
        action = "<Nop>";
        mode = "i";
        desc = "Disable Down arrow in insert mode";
      }
      {
        key = "<Left>";
        action = "<Nop>";
        mode = "i";
        desc = "Disable Left arrow in insert mode";
      }
      {
        key = "<Right>";
        action = "<Nop>";
        mode = "i";
        desc = "Disable Right arrow in insert mode";
      }
    ];
  };
}
