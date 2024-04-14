{ pkgs, inputs, ... }: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    # enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  hardware = {
    opengl.enable = true;
  };


  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    waybar

    mako
    libnotify

    swww
    pywal

    rofi-wayland
    rofi-power-menu
    tofi

    wlogout
    swaylock-effects
  ];

  security.pam.services.swaylock = { };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
