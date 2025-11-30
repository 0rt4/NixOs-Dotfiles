{ config, pkgs, lib, ... }:
{
  # Graphics (antes OpenGL)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    # Paquetes adicionales para graphics
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libva-vdpau-driver
    ];
  };
  
  # NVIDIA (descomenta si tienes GPU NVIDIA)
   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.nvidia = {
     modesetting.enable = true;
     powerManagement.enable = false;
     powerManagement.finegrained = false;
     open = false;
     nvidiaSettings = true;
     package = config.boot.kernelPackages.nvidiaPackages.stable;
   };
  # AMD (descomenta si tienes GPU AMD)
  # services.xserver.videoDrivers = [ "amdgpu" ];
  # hardware.graphics.extraPackages = with pkgs; [
  #   rocm-opencl-icd
  #   rocm-opencl-runtime
  # ];
  # Intel (ya incluido arriba, pero puedes especificar el driver)
  # services.xserver.videoDrivers = [ "modesetting" ];
  # Paquetes de video
  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    # gpu-screen-recorder  # Para grabación de pantalla con GPU
  ];
}
