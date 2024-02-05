{

  programs.nixvim.plugins.luasnip.enable = true;
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      rnix-lsp.enable = true;
      lua-ls.enable = true;
      gopls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      jsonls.enable = true;
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
    mapping = {
      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-e>" = "cmp.mapping.abort()";
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = {
        action = "cmp.mapping.select_next_item()";
        modes = [
          "i"
          "s"
        ];
      };

      "<Down>" = {
        action = "cmp.mapping.select_next_item()";
        modes = [
          "i"
          "s"
        ];
      };

      "<Up>" = {
        action = "cmp.mapping.select_prev_item()";
        modes = [
          "i"
          "s"
        ];
      };


    };
    snippet.expand = "luasnip";
  };


  programs.nixvim.plugins.cmp-nvim-lsp-signature-help.enable = true;

  programs.nixvim.plugins.treesitter = {
    enable = true;
    ensureInstalled = [
      "http"
      "json"
      "nix"
      "lua"
      "go"
    ];
  };

  programs.nixvim.plugins.lspsaga = {
    enable = true;
    beacon.enable = true;
    symbolInWinbar.enable = true;
    rename.autoSave = true;
  };


  programs.nixvim.plugins.trouble.enable = true;


  programs.nixvim.filetype.filename = {
    "Justfile" = "make";
  };

  programs.nixvim.filetype.extension = {
    "http" = "http";
  };
}
