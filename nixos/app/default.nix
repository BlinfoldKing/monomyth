{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-19.1.9"
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager-openvpn

    google-chrome
    beekeeper-studio
    discord
    insomnia
    etcher
    woeusb

    git
    kitty
    just
    grim
    slurp
    wl-clipboard
    grimblast

    gnome3.gvfs
    gnome3.nautilus
    gparted

    vlc
    libvlc

    ripgrep
    bat
    eza
    fzf
    zoxide
    yazi
    viu
    tmux
    zellij
    zenith
  ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  # enable controller
  hardware.xpadneo.enable = true;
  #
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "zoxide" ];
    };
    shellAliases = {
      cd = "z";
      ls = "eza";
      cls = "clear";
      file = "yazi";
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
