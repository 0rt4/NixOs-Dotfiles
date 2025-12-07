{ config, lib, pkgs, ... }:

with lib;

{
  options.desktops.plasma = {
    enable = mkEnableOption "KDE Plasma Desktop";
<<<<<<< Updated upstream
    
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs.kdePackages; [
        # kate
        # ark
        # dolphin
        # spectacle
        # okular

        # plasma-systemmonitor
        # kinfocenter
        # plasma-workspace-wallpapers
      ];
      description = "Aplicaciones extra de KDE";
    };

    kdeconnect.enable = true;
  };


  config = mkIf config.desktops.plasma.enable {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = config.desktops.plasma.extraPackages;
=======

    extraPackages = mkOption {
      description = "Aplicaciones extra de KDE";
      type = types.listOf types.package;
      default = with pkgs.kdePackages; [
        # Paquetes específicos de KDE Plasma
      ];
    };

    excludePackages = mkOption {
      description = "Paquetes de KDE a excluir";
      type = types.listOf types.package;
      default = with pkgs.kdePackages; [
        elisa
        gwenview
        konsole
        kwalletmanager
        kate  # kwrite es parte de kate en Plasma 6
        okular
        kcharselect
      ];
    };

    kdeconnect.enable = mkEnableOption "KDE Connect";
  };

  config = mkIf config.desktops.plasma.enable {
    services.desktopManager.plasma6.enable = true;
    environment.systemPackages = config.desktops.plasma.extraPackages;
    environment.plasma6.excludePackages = config.desktops.plasma.excludePackages;
>>>>>>> Stashed changes
  };
}