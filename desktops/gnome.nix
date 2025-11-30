{ config, pkgs, lib, ... }:
{
  # Habilitar GNOME (forma moderna)
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };

  # Habilitar servicios core de GNOME
  services.gnome = {
    core-apps.enable = false;
    games.enable = false;
    core-developer-tools.enable = false;
    gnome-keyring.enable = true;

  };
  
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];
  # Paquetes específicos para GNOME
  environment.systemPackages = with pkgs; [
    # Herramientas de GNOME
    gnome-tweaks
    gnome-extension-manager
		gparted
    dconf-editor
    baobab
    gnome-control-center
    glib
    gnome-text-editor
    loupe
    # Extensiones
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
    
    # Aplicaciones de GNOME útiles
    gnome-calendar
    
    # Theme y personalización
    adwaita-icon-theme
  ];
  
  # Portal de GNOME
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  #};
}
