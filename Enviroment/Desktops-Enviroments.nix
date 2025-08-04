{ config, lib, pkgs, ... }:

let
  # ===== Variables de Control =====
  enableGNOME = true;     # Activa GNOME como escritorio
  enablePlasma = false;   # Activa KDE Plasma (desactivado)
  enableHyprland = false; # Activa Hyprland (desactivado)

  # Lista plana de imports (sin listas anidadas)
  desktopImports = 
    (if enableGNOME then [./Gnome-Setup.nix] else []) ++
    (if enablePlasma then [./KDE-Plasma-Setup.nix] else []) ++
    (if enableHyprland then [./Hyprland-Setup.nix] else []);

in {
  imports = desktopImports;

  # ===== Configuración del Gestor de Pantalla =====
  services.displayManager = {
    gdm.enable = enableGNOME;  # Wayland es automático en GNOME
    sddm.enable = enablePlasma;
  };

  # ===== Configuración de Entornos de Escritorio =====
  services.desktopManager = {
    gnome.enable = enableGNOME;
    plasma6.enable = enablePlasma;
  };
}
