{ config, lib, pkgs, inputs, ... }:

with lib;

{
  # 1. EL CAMBIO MÁS IMPORTANTE: Los imports externos van AFUERA del bloque config
  imports = [ inputs.mango.nixosModules.mango ];

  options.desktops.mangowc = {
    enable = mkEnableOption "Mango Wayland compositor";

    packages = mkOption {
      type = types.listOf types.package;
      description = "Dependencias para MangoWC";
      default = with pkgs; [
        fuzzel
        waybar
        swaybg
        wl-clipboard
        polkit_gnome
        mpvpaper
      ];
    };
  };

  config = mkIf config.desktops.mangowc.enable {
    # Borramos la línea 'import = ...' de aquí adentro

    programs.mango = {
      enable = true;
    };
 
    environment.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = lib.mkForce "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    environment.systemPackages = config.desktops.mangowc.packages;

    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # 2. CORRECCIÓN DE TYPO: portal-gtk (te faltaba la 'l')
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };
}
