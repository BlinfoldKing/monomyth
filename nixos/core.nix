{ pkgs, lib, nix-colors, inputs, system, ... }: {
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
    disfetch
    os-prober
    polkit_gnome
    xorg.xhost
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


  # override default config
  boot.loader = {
    systemd-boot.enable = false;
    efi.efiSysMountPoint = "/boot";

    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
      useOSProber = true;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 08ca7ca5-e615-4168-8f45-d01b5017b0bd
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  time.hardwareClockInLocalTime = true;
}
