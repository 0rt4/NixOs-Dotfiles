{ config, pkgs, lib, ... }:
{
  programs.niri.enable = true;
  
  # Software indispensable para Niri
  environment.systemPackages = with pkgs; [
    niri
    #eww
    pulseaudio
    brightnessctl
    swaynotificationcenter
    #swww
    hyprlock
    rofi-wayland 
    imagemagick
    mpvpaper
    polkit_gnome
    xwayland-satellite
		unstable.quickshell
		qml-niri
		qt6.qt5compat
  ];
  
  # Variables de entorno para Niri
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QML_IMPORT_PATH = "${pkgs.qml-niri}/lib/qt-6/qml";

  };
  
  # Habilitar servicios necesarios
  services.gnome.gnome-keyring.enable = true;

  #servicio de polkit
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
}
