{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager-openvpn

    google-chrome
    discord
    insomnia

    git
    kitty
    just
    grim
    slurp
    wl-clipboard
    grimblast

    gnome3.gvfs
    gnome3.nautilus
  ];


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  # enable controller
  hardware.xpadneo.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  programs.starship = {
    enable = true;
  };

  imports = [
    ./android/default.nix
  ];
}
