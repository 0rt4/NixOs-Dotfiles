{ config, pkgs, lib, ... }:

{
  # ===== HEREDAR CONFIGURACIÓN COMÚN =====
  imports = [
    ./packages/hyprland.nix                 # PAQUETES ESPECIFICOS
  ];
  
  # ===== HABILITAR HYPRLAND =====
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;  # Soporte para aplicaciones X11
  };

  # Habilitar Xserver solo para el display manager
  services.xserver.enable = true;
  
  # ===== PORTAL XDG PARA WAYLAND =====
  xdg.portal = {
    enable = true;
    wlr.enable = true;  # Soporte para protocolos wlroots
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  
  # ===== VARIABLES DE ENTORNO ESPECÍFICAS PARA HYPRLAND/WAYLAND =====
  environment.sessionVariables = {
    # Variables generales de Wayland
    NIXOS_OZONE_WL = "1";             # Soporte para aplicaciones Electron/Ozone
    WLR_NO_HARDWARE_CURSORS = "1";    # Solución para problemas de cursor
    GDK_BACKEND = "wayland,x11";      # Backend para GTK
    QT_QPA_PLATFORM = "wayland;xcb";  # Plataforma para Qt
    
    # Variables específicas de NVIDIA para Wayland
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  
  # ===== POLKIT =====
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
  
  # ===== SONIDO: PipeWire + WirePlumber =====
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}

