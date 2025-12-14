{ config, pkgs, ... }:

{
  # Driver NVIDIA para GTX 1650
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting necesario para Wayland
    modesetting.enable = true;

    # Configuración de energía (para laptops)
    powerManagement = {
      enable = false;
      finegrained = false;
    };

    # Driver propietario (no open source para GTX 1650)
    open = false;

    # Panel de control NVIDIA
    nvidiaSettings = true;

    # Versión del driver
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Si tienes iGPU Intel + NVIDIA (híbrido)
    prime = {

       sync.enable = true;

       intelBusId = "PCI:0:2:0";
       nvidiaBusId = "PCI:1:0:0";
    };
  };

  # OpenGL/Vulkan
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Paquetes útiles
  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    nvtopPackages.nvidia
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
