{ pkgs, config, lib, ... }:

{
  # === Aplicaciones no deseadas ===
  environment.gnome.excludePackages = with pkgs; [
    # Apps que NO quieres (personaliza esta lista)
    cheese           # Cámara web
    gnome-connections  # Conexiones remotas
    seahorse         # Administrador de claves
    gnome-music      # Reproductor de música
    epiphany         # Navegador web
    gnome-tour       # Tour introductorio
    gnome-maps       # Mapas
    gnome-contacts         # Contactos
    gnome-weather          # Meteorología
    gnome-clocks             # Ayuda/Documentación (yelp es el visor de ayuda)
    gnome-characters    # Visor de caracteres especiales
    gnome-console       # Terminal de GNOME (reemplázala por tu terminal preferida)
    yelp
    totem
    xterm
  ];
  
  environment.systemPackages = with pkgs; [
    # Herramientas de GNOME
    gnome-tweaks
    gnome-extension-manager
    gnome-shell-extensions
    gnome-disk-utility  # Analizador de discos (baobab)
    gnome-system-monitor  # Monitor del sistema
    gnome-logs          # Visor de registros (logs)
    
    #Extensiones
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    gnomeExtensions.gsconnect
    gnomeExtensions.openweather-refined
    gnomeExtensions.forge
    gnomeExtensions.fuzzy-app-search
    gnomeExtensions.app-menu-is-back
    gnomeExtensions.open-bar
    gnomeExtensions.tiling-shell
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.search-light
    gnomeExtensions.burn-my-windows
    gnome-extension-manager   # Gestor de extensiones (alternativo)
  ];
  
    # === Configuración de servicios GNOME ===
  services.gnome = {
    core-shell.enable = true;       # Shell básico de GNOME
    core-apps.enable = true;        # Habilita apps básicas (incluye disk-utility, system-monitor, logs)
    core-utilities.enable = true;   # Utilidades básicas (necesario para algunas herramientas)
    core-developer-tools.enable = false;  # Desactiva si no necesitas herramientas de desarrollo
  };
  # Mejorar soporte para Wayland/NVIDIA
  services.xserver.displayManager.gdm.wayland = config.hardware.nvidia.enabled;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
