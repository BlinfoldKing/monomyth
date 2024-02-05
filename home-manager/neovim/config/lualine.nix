{
  programs.nixvim.plugins.lualine = {
    enable = true;
    globalstatus = true;
    extensions = [ "nvim-tree" "fugitive" ];
  };
}
