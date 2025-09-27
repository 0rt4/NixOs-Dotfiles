{ config, pkgs, lib, ... }:

{
  # ===== HEREDAR CONFIGURACIÓN COMÚN =====
  imports = [ 
    ./packages/gnome.nix   # PAQUETES ESPECÍFICOS PARA GNOME
  ];
  
  # ===== HABILITAR GNOME =====
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
 
  # ===== CONFIGURACIONES ESPECIALES =====
  programs.dconf.enable = true;  # Necesario para GNOME
  services.dbus.packages = [ pkgs.gcr ];  # Soporte para keyring
  
  # ===== VARIABLES DE ENTORNO ESPECÍFICAS PARA GNOME =====
  environment.sessionVariables = {
    # Solo variables necesarias para GNOME con NVIDIA
    NIXOS_OZONE_WL = "1";  # Para aplicaciones web en Wayland
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";  # Para OpenGL con NVIDIA
  };
  
  # ===== HOME MANAGER PARA USUARIO ORTA =====
  home-manager.users.orta = {
    imports = [ ../home-manager/gnome.nix ];
  };
}
