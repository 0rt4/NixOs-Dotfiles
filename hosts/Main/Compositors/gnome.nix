{ config, pkgs, ... }:

{
  services.desktopManager.gnome.enable = true;
  
  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
    gnome-keyring.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    # Herramientas de GNOME
    nautilus
    gnome-tweaks
    gnome-extension-manager
    gnome-control-center
    gnome-text-editor
    
    # Extensiones
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
    
    # Aplicaciones útiles
    gnome-calendar
  ];
  
  # Paquetes a excluir - comentados los que no existen
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-terminal
  ];
}
