{ pkgs, lib, nix-colors, inputs, system, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./drivers/default.nix
    ./wm/default.nix
    ./app/default.nix
    ./languages/default.nix
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];


  environment.systemPackages = with pkgs; [
    gnumake
    just
    ripgrep
    home-manager
    gnumake
    wget
    jq
    html-tidy
    httpie
  ];

  nix.settings.warn-dirty = false;

  fonts.packages = with pkgs; [
    fira-code
    victor-mono
    font-awesome
    ibm-plex
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];
  fonts.fontconfig.defaultFonts.monospace = [ "CascadiaCode" "Fira Code" "Victor Mono" ];

  environment.variables.EDITOR = "nvim";

}
