{
  programs.nixvim.plugins = {
    fugitive.enable = true;
    gitblame.enable = true;
  };


  programs.nixvim.plugins.gitsigns = {
    enable = true;
  };
}
