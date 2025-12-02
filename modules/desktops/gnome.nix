{ config, lib, pkgs, ... }:

with lib;

{
  options.desktops.gnome = {
    enable = mkEnableOption "GNOME Desktop";
    
    excludePackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        #gnome-tour
        #gnome-connections
        epiphany
        geary
      ];
      description = "Paquetes de GNOME a excluir";
    };
    
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
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
      description = "Paquetes extra para GNOME";
    };
  };

  config = mkIf config.desktops.gnome.enable {
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = config.desktops.gnome.excludePackages;
    environment.systemPackages = config.desktops.gnome.extraPackages;
    
    # Keyring
    services.gnome.gnome-keyring.enable = true;

  };
}