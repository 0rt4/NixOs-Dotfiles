{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.desktops.cosmic;
in
{
  options.desktops.cosmic = {
    enable = mkEnableOption "COSMIC Desktop";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        # Paquetes específicos de COSMIC
      ];
      description = "Paquetes extra para COSMIC";
    };
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    environment.systemPackages = cfg.extraPackages;
  };
}
