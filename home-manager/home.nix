# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, username
, ...
}:
let submoduleArgs = {
  inherit pkgs inputs lib config; palette = config.colorScheme.palette;
};
in
{
  # colorScheme = inputs.nix-colors.colorSchemes.onedark;
  # colorScheme = inputs.nix-colors.colorSchemes.onedark;
  colorScheme = inputs.nix-colors.lib.schemeFromYAML "onedark" (builtins.readFile ../theme.yaml);
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other fl libakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.nix-colors.homeManagerModules.default
    ./gtk.nix
    ./starship.nix
    ./neovim/default.nix
    (import ./zellij.nix submoduleArgs)
    (import ./rofi.nix submoduleArgs)
    (import ./mako.nix submoduleArgs)
    (import ./kitty.nix submoduleArgs)
    (import ./hyprland/default.nix submoduleArgs)
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git =
    {
      enable = true;
      userName = "Ganesha Danu";
      userEmail = "ganeshadanu1@gmail.com";

      extraConfig = {
        url = {
          "git@bitbucket.org:".insteadOf = "https://bitbucket.org/";
          "git@github.com".insteadOf = "https://bitbucket.org/";
        };
      };

    };

  programs.zsh = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
