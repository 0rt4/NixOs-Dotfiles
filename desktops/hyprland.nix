{ config, pkgs, lib, ... }:

{
  # Habilitar Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

    # ===== VARIABLES DE ENTORNO ESPECÍFICAS PARA HYPRLAND/WAYLAND =====
  environment.sessionVariables = {
    # Variables generales de Wayland
    NIXOS_OZONE_WL = "1";             # Soporte para aplicaciones Electron/Ozone
    WLR_NO_HARDWARE_CURSORS = "1";    # Solución para problemas de cursor
    GDK_BACKEND = "wayland,x11";      # Backend para GTK
    QT_QPA_PLATFORM = "wayland;xcb";  # Plataforma para Qt
    GTK_THEME = "Adwaita-dark";
    # Variables específicas de NVIDIA para Wayland
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Paquetes específicos para Hyprland
  environment.systemPackages = with pkgs; [
    # Compositor y herramientas
    hyprland
    hyprpaper
    hyprlock
    hypridle
    hyprpicker
    
    # Barra y menús
    #unstable.quickshell
    #waybar
    #wofi
    #rofi-wayland
    
    # Notificaciones
    #dunst
    #libnotify
    
    # Gestión de sesión
    polkit_gnome
    
    # Clipboard / utilidades
    cliphist
    inotify-tools
    #mako
    
    
    # Herramientas útiles
    #swww
    #wlogout
    #pavucontrol
    #brightnessctl
    
    # Terminal recomendado
    kitty
  ];

  # Polkit para autenticación
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

  # Habilitar servicios necesarios
  services.gnome.gnome-keyring.enable = true;
  
  # Portal específico de Hyprland
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
}
