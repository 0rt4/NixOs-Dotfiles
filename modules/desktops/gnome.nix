{ config, lib, pkgs, ... }:

with lib;

{
  options.desktops.gnome = {
    enable = mkEnableOption "GNOME Desktop";
<<<<<<< Updated upstream
    
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
=======

    extraPackages = mkOption {
      description = "Paquetes extra para GNOME";
>>>>>>> Stashed changes
      type = types.listOf types.package;
      default = with pkgs; [
        # Herramientas de GNOME
        gnome-tweaks
        gnome-extension-manager
<<<<<<< Updated upstream
        gparted
        dconf-editor
        baobab
        gnome-control-center
        glib
        gnome-text-editor
        loupe
=======
        # conf-editor
        gnome-control-center
        # glib
        gnome-text-editor
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
        
        # Aplicaciones de GNOME útiles
        gnome-calendar
        
        # Theme y personalización
        adwaita-icon-theme
      ];
      description = "Paquetes extra para GNOME";
=======

        # Aplicaciones de GNOME útiles
        gnome-calendar

        # Theme y personalización
        # adwaita-icon-theme
      ];
    };

    excludePackages = mkOption {
      description = "Paquetes de GNOME a excluir";
      type = types.listOf types.package;
      default = with pkgs; [
        #gnome-tour
        #gnome-connections
        epiphany
        geary
      ];
>>>>>>> Stashed changes
    };
  };

  config = mkIf config.desktops.gnome.enable {
<<<<<<< Updated upstream
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = config.desktops.gnome.excludePackages;
    environment.systemPackages = config.desktops.gnome.extraPackages;
    
=======
    services.desktopManager.gnome.enable = true;

		services.gnome.core-apps.enable = false;
  		services.gnome.core-developer-tools.enable = false;
  		services.gnome.games.enable = false;


    environment.gnome.excludePackages = config.desktops.gnome.excludePackages;
    environment.systemPackages = config.desktops.gnome.extraPackages;

>>>>>>> Stashed changes
    # Keyring
    services.gnome.gnome-keyring.enable = true;

  };
<<<<<<< Updated upstream
}
=======
}
>>>>>>> Stashed changes
