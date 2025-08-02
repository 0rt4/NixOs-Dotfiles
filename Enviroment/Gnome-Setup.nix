{ lib, pkgs, ... }:

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
    #gnome-shell-extensions  # (Opcional: si usas extension-manager)
  ];

  # === Aplicaciones extra ===
  environment.systemPackages = with pkgs; [
    # Herramientas de sistema que deseas conservar
    gnome-disk-utility  # Analizador de discos (baobab)
    gnome-system-monitor  # Monitor del sistema
    gnome-logs          # Visor de registros (logs)
    
    # Herramientas adicionales de personalización
    gnome-tweaks        # Tweaks para GNOME
    gnome-extension-manager   # Gestor de extensiones (alternativo)
  ];

  # === Configuración de servicios GNOME ===
  services.gnome = {
    core-shell.enable = true;       # Shell básico de GNOME
    core-apps.enable = true;        # Habilita apps básicas (incluye disk-utility, system-monitor, logs)
    core-utilities.enable = true;   # Utilidades básicas (necesario para algunas herramientas)
    core-developer-tools.enable = false;  # Desactiva si no necesitas herramientas de desarrollo
  };

  # Necesario para el keyring de GNOME
  services.dbus.packages = [ pkgs.gcr ];
}
