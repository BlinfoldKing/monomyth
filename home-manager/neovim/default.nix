{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config/default.nix
    ./config/default.nix
  ];

  programs.nixvim.enable = true;
  programs.nixvim.clipboard.register = "unnamedplus";
}
