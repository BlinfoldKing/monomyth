{ pkgs, lib, nix-colors, inputs, system, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./drivers/default.nix
    ./wm/default.nix
    ./app/default.nix
  ];

  environment.systemPackages = with pkgs; [
    gcc
    ripgrep
    home-manager
  ];

  nix.settings.warn-dirty = false;

  fonts.packages = with pkgs; [
    pkgs.fira-code
    pkgs.victor-mono
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];
  fonts.fontconfig.defaultFonts.monospace = [ "CascadiaCode" "Fira Code" "Victor Mono" ];

}
