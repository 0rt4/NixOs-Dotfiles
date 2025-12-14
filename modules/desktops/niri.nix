{ config, lib, pkgs, inputs, ... }:

with lib;

{
  options.desktops.niri = {
    enable = mkEnableOption "Niri Wayland compositor";
    
    packages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        fuzzel
        swaynotificationcenter
        # waybar
        hyprlock
        mpvpaper
        xwayland-satellite
        wf-recorder
        slurp
        wl-clipboard
      ];
      description = "Paquetes para Niri";
    };
  };

  config = mkIf config.desktops.niri.enable {
    # Variables de entorno para Wayland - SOLO CON NIRI ACTIVO
    environment.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT ="wayland";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      # QML_IMPORT_PATH = "${pkgs.qml-niri}/lib/qt-6/qml";
			#SHELL = "${pkgs.fish}/bin/fish";
    };

    # Usa el flake de niri (ya importado en flake.nix)
    programs.niri = {
      enable = true;
      package = pkgs.niri;  # Usar el de nixpkgs
    };
    
    environment.systemPackages = config.desktops.niri.packages;
    
    # Wayland común
    security.polkit.enable = true;
    
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };
}
