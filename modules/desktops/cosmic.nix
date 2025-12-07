{ config, lib, pkgs, ... }:

with lib;

<<<<<<< Updated upstream
{
  options.desktops.cosmic = {
    enable = mkEnableOption "COSMIC Desktop";
    
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
=======
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
>>>>>>> Stashed changes
      description = "Paquetes extra para COSMIC";
    };
  };

<<<<<<< Updated upstream
  config = mkIf config.desktops.cosmic.enable {
    # Usa el flake de COSMIC (ya importado en flake.nix)
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    environment.systemPackages = config.desktops.cosmic.extraPackages;
  };
}
=======
  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    environment.systemPackages = cfg.extraPackages;
  };
}
>>>>>>> Stashed changes
