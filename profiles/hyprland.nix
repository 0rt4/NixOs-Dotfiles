{ config, pkgs, lib, ... }:

{
  # ===== HEREDAR CONFIGURACIÓN COMÚN =====
  imports = [
    ./default.nix                                 # CONFIGURACIONES 
    ../packages/hyprland-pkgs.nix                    # PAQUETES ESPECIFICOS
    {
      home-manager.users.orta = {
        imports = [ ../home-manager/hyprland.nix ];  # HOME MANAGER
      };
    }
  ];

   # ===== HABILITAR HYPRLAND =====
  programs.hyprland = {
    enable = true;
    withUWSM=true;
    xwayland.enable = true;  # Soporte para aplicaciones X11
  };

  # Habilitar Xserver solo para el display manager
  services.xserver.enable = true;
  
  # ===== PORTAL XDG PARA WAYLAND =====
  xdg.portal = {
    enable = true;
    wlr.enable = true;  # Soporte para protocolos wlroots
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];  # Portal GTK
  };
  
  # ===== VARIABLES DE ENTORNO ESPECÍFICAS PARA HYPRLAND/WAYLAND =====
  environment.sessionVariables = {
    # Variables generales de Wayland
    NIXOS_OZONE_WL = "1";  # Soporte para aplicaciones Electron/Ozone
    WLR_NO_HARDWARE_CURSORS = "1";  # Solución para problemas de cursor
    GDK_BACKEND = "wayland,x11";  # Backend para GTK
    QT_QPA_PLATFORM = "wayland;xcb";  # Plataforma para Qt
    
    # Variables específicas de NVIDIA para Wayland
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
