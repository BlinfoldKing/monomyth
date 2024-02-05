{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config/default.nix
    ./config/default.nix
  ];

  programs.nixvim.enable = true;
  programs.nixvim.clipboard.providers.xclip = {
    enable = true;
    package = pkgs.xclip;
  };
  # programs.nixvim.globals.mapleader = "<Space>";
}
