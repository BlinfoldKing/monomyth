{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    android-studio
  ];

  programs.adb.enable = true;
  users.users.blinfoldking.extraGroups = [ "adbusers" ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}

