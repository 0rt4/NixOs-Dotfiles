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
<<<<<<< Updated upstream
      finegrained = false;  # Cambia a true si quieres NVIDIA On-Demand
=======
      finegrained = false;
>>>>>>> Stashed changes
    };

    # Driver propietario (no open source para GTX 1650)
    open = false;

    # Panel de control NVIDIA
    nvidiaSettings = true;

<<<<<<< Updated upstream
    # Versión del driver (stable es la recomendada)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # Si tienes iGPU Intel + NVIDIA (híbrido)
    prime = {
      # Descomenta y configura según tu hardware
      # Encuentra los IDs con: lspci | grep -E "VGA|3D"
      
       offload = {
         enable = true;
         enableOffloadCmd = true;
       };
      
=======
    # Versión del driver
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Si tienes iGPU Intel + NVIDIA (híbrido)
    prime = {

       sync.enable = true;

>>>>>>> Stashed changes
       intelBusId = "PCI:0:2:0";
       nvidiaBusId = "PCI:1:0:0";
    };
  };

  # OpenGL/Vulkan
  hardware.graphics = {
    enable = true;
<<<<<<< Updated upstream
    enable32Bit = true;  # Para juegos de 32-bit
=======
    enable32Bit = true;
>>>>>>> Stashed changes
  };

  # Paquetes útiles
  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
<<<<<<< Updated upstream
    nvtopPackages.nvidia  # Monitor de GPU
    # nvidia-offload  # Si usas PRIME offload
  ];

  # Variables de entorno para Wayland + NVIDIA
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";  # Fix para algunos compositores
  };
}
=======
    nvtopPackages.nvidia
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
>>>>>>> Stashed changes
