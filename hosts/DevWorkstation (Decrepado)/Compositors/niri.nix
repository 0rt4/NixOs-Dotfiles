{ config, pkgs, ... }:

{
  # Habilitar Niri
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
  
  # Variables de entorno para Wayland
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
  
  # Paquetes para Niri
  environment.systemPackages = with pkgs; [
    #fuzzel
    #swaynotificationcenter
    #hyprlock
    #mpvpaper
    #xwayland-satellite
    #wf-recorder
    #slurp
    #grim
    #wl-clipboard
    #brightnessctl
    #polkit_gnome
  ];
}
