{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ 
  "modesetting"
  "nvidia"
  ];

  hardware.nvidia = {
        powerManagement.enable = false;
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      #sync.enable = true;
      reverseSync.enable = true;
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    #mesa-demos
    #vulkan-tools
    #nvtopPackages.nvidia
  ];

  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    WLR_DRM_NO_ATOMIC = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    NIXOS_OZONE_WL = "1";
  };
}
