{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    android-studio
  ];

  programs.adb.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}

