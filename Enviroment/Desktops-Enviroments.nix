{ config, lib, pkgs, ... }:

let
  # ===== VARIABLES DE CONTROL DE ENTORNOS =====
  enableGNOME = true;     # Controla si GNOME está activado
  enablePlasma = false;   # Controla si KDE Plasma está activado
  enableHyprland = false; # Controla si Hyprland está activado

  # ===== LISTA DE IMPORTS CONDICIONALES =====
  # (Editado aquí: ahora usa lib.optional correctamente)
  desktopImports = []
    ++ lib.optional enableGNOME ./Gnome-Setup.nix
    ++ lib.optional enablePlasma ./KDE-Plasma-Setup.nix
    ++ lib.optional enableHyprland ./Hyprland-Setup.nix;

in {
  imports = desktopImports;

  # ===== CONFIGURACIÓN PRINCIPAL DEL SERVIDOR X =====
  services.xserver = {
    enable = true;  # (Añadido: necesario para activar cualquier entorno gráfico)

    # ===== GESTOR DE PANTALLA (GDM) =====
    displayManager.gdm = {
      enable = true;    # GDM como gestor universal
      wayland = true;   # Soporte para Wayland
    };

    # ===== ESCRITORIOS (EDITADO IMPORTANTE AQUÍ) =====
    # Cambié de services.desktopManager a services.xserver.desktopManager
    desktopManager = {
      gnome.enable = enableGNOME;   # GNOME ahora va dentro de xserver
      plasma6.enable = enablePlasma; # Plasma también va aquí
    };
  };


  # ===== HYPRLAND (OPCIONAL) =====
  # programs.hyprland = {
  #   enable = enableHyprland;
  #   xwayland.enable = true;  # Necesario para muchas apps
  #   nvidiaPatches = false;   # Activar si usas NVIDIA
  # };
}
