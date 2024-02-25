{ pkgs
, lib
, nix-colors
, inputs
, system
, username
, hostname
, ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    /etc/nixos/configuration.nix
    ./drivers/default.nix
    ./wm/default.nix
    ./app/default.nix
    ./languages/default.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    alsa-lib
    pkg-config
    udev
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
    neofetch
    os-prober
    polkit_gnome
    xorg.xhost
    entr
    pkg-config
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


  # polkit authentication setup
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };


  time.hardwareClockInLocalTime = true;

  services.xserver.xkb = lib.mkForce {
    layout = "us";
    variant = "";
  };


  users.users.${username}.extraGroups = [ "docker" "adbusers" ];
}
