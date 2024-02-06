{
  programs.nixvim.keymaps = [
    {
      key = "tt";
      action = "<cmd>NvimTreeToggle<CR>";
      options = { noremap = true; silent = true; };
    }
    {
      key = "<Esc>";
      mode = "t";
      action = "<C-\\><C-n>";
      options = { noremap = true; silent = true; };
    }
  ];

  programs.nixvim.plugins.which-key = {
    enable = true;
    window = {
      position = "bottom";
      winblend = 0;
    };
    registrations = {
      "<Space>" = {
        "?" = [ "<cmd>Cheatsheet<cr>" "Cheatsheet" ];
        "<Space>" = [ "<Plug>(easymotion-prefix)" "Easymotion" ];
        c = {
          name = "config";
          r = [ "<cmd>source ~/.config/nvim/.vimrc<cr>" "reload .vimrc" ];
          e = [ "<cmd>edit ~/.config/nvim/.vimrc<cr>" "edit .vimrc" ];
          "?" = [ "<cmd>CheatsheetEdit<cr>" "edit cheatsheet" ];
        };
        f = {
          name = "file and finder";
          t = [ "<cmd>NvimTreeToggle<cr>" "file tree" ];
          f = [ "<cmd>Telescope find_files<cr>" "find file" ];
          b = [ "<cmd>Telescope buffers<cr>" "find buffer" ];
          p = [ "<cmd>Telescope live_grep<cr>" "find pattern" ];
        };
        s = {
          name = "save";
          s = [ "<cmd>w<cr>" "save" ];
          q = [ "<cmd>wq<cr>" "save and quit" ];
        };
        g = {
          name = "git";
          s = [ "<cmd>Git<cr>" "status" ];
          c = [ "<cmd>Git commit<cr>" "commit" ];
          p = [ "<cmd>Git push<cr>" "push" ];
          h = [ "<cmd>DiffviewFileHistory<cr>" "history" ];
          d = [ "<cmd>DiffviewOpen<cr>" "open diff" ];
          D = [ "<cmd>DiffviewClose<cr>" "closs diff" ];
        };
        l = {
          name = "language";
          t = {
            name = "tag and symbol";
            o = [ "<cmd>Lspsaga outline<cr>" "outline" ];
            f = [ "<cmd>Telescope treesitter<cr>" "find symbol" ];
          };
          l = {
            name = "LSP";
            h = [ "<cmd>Lspsaga hover_doc<CR>" "hover doc" ];
            f = [ "<cmd>Lspsaga lsp_finder<CR>" "finder" ];
            r = [ "<cmd>Lspsaga rename<CR>" "rename" ];
            a = [ "<cmd>Lspsaga code_action<CR>" "code action" ];
            s = [ "<cmd>Lspsaga signature_help<CR>" "signature help" ];
            D = [ "<cmd>TroubleToggle workspace_diagnostics<CR>" "workspace diagnostic" ];
            d = [ "<cmd>TroubleToggle document_diagnostics<CR>" "document diagnostic" ];
          };
        };
        t = {
          name = "terminal";
          t = [ "<cmd>ToggleTerm direction=float<cr>" "float" ];
          h = [ "<cmd>ToggleTerm size=20 direction=horizontal<cr>" "horizontal" ];
          v = [ "<cmd>ToggleTerm size=50 direction=vertical<cr>" "vertical" ];
        };
        w = {
          name = "window";
          s = [ "<cmd>WinShift<cr>" "shift window" ];
        };
        "n" = [
          "<cmd>Telescope notify<cr>"
          "notifications"
        ];
        q = [ "<cmd>qa!<cr>" "close all and exit" ];
        h = {
          name = "http action";
          t = [
            ''
              <cmd>lua require("rest-nvim").run_file(vim.fn.expand("%:p"), { keep_going = true })<cr>
            ''
            "run http request"
          ];
        };
      };
    };
  };
}
