{ config, pkgs, ... }:

{
  imports = [ ./default.nix ]; 
  # ===== CONFIGURACIÓN HYPRLAND =====
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      # Importar configuraciones desde archivos separados
      source = [
        "./hyprland-conf/monitors.conf"
      ];
    };
  };
