{ config, pkgs, ... }:

{
  # Configuración de hardware gráfico (NO activar Xserver aquí)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Configuración específica de NVIDIA
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Solo drivers X11 (necesario para ambos entornos)
  services.xserver.videoDrivers = [ "nvidia" ];

  # Paquetes relacionados con gráficos (comunes para ambos entornos)
  environment.systemPackages = with pkgs; [
    vulkan-tools
    libvdpau-va-gl
    glxinfo
    mesa
  ];
}
