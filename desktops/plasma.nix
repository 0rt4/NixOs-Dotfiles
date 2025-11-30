{ config, pkgs, lib, ... }:

{
  # Habilitar KDE Plasma
  services.xserver.desktopManager.plasma5.enable = true;

  # Paquetes específicos para KDE Plasma
  environment.systemPackages = with pkgs; [
    # Aplicaciones de KDE
    kdePackages.kate
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.spectacle
    
    # Herramientas de sistema KDE
    kdePackages.plasma-systemmonitor
    kdePackages.kinfocenter
    kdePackages.plasma-browser-integration
    
    # Personalización
    kdePackages.plasma-workspace-wallpapers
  ];

  # Servicios de KDE
  programs.kdeconnect.enable = true;
  
  # Habilitar el portal de KDE
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  # Integración con servicios del sistema
  services.gnome.gnome-keyring.enable = true;
}
