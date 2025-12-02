{ config, lib, pkgs, ... }:

with lib;

{
  options.desktops.plasma = {
    enable = mkEnableOption "KDE Plasma Desktop";
    
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
  };
}