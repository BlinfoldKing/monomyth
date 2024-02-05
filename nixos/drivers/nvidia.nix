{ config, ... }: {
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    modesetting.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
