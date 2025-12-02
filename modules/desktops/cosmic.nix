{ config, lib, pkgs, ... }:

with lib;

{
  options.desktops.cosmic = {
    enable = mkEnableOption "COSMIC Desktop";
    
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Paquetes extra para COSMIC";
    };
  };

  config = mkIf config.desktops.cosmic.enable {
    # Usa el flake de COSMIC (ya importado en flake.nix)
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    environment.systemPackages = config.desktops.cosmic.extraPackages;
  };
}