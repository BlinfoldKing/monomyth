{ config, ... }: {
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
