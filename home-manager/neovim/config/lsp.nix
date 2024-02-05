{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      rnix-lsp.enable = true;
      lua-ls.enable = true;
    };
  };

  programs.nixvim.plugins.nvim-cmp = {
    enable = true;
    autoEnableSources = true;
    sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
    ];
  };

  programs.nixvim.plugins.treesitter = {
    enable = true;
    ensureInstalled = [
      "nix"
      "lua"
    ];
  };

  programs.nixvim.plugins.lspsaga = {
    enable = true;
    beacon.enable = true;
    symbolInWinbar.enable = true;
    rename.autoSave = true;
  };


  programs.nixvim.plugins.trouble.enable = true;
}
