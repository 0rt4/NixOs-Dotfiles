{ pkgs, lib, ... }:

{
  # ===== PAQUETES ESENCIALES =====
  environment.systemPackages = with pkgs; [
    hyprland
    waybar           # Barra de estado
    rofi-wayland     # Menú de aplicaciones
    swaylock-effects # Bloqueo de pantalla
    swayidle         # Gestión de inactividad
    wl-clipboard     # Portapapeles
    grim             # Capturas de pantalla
    slurp            # Selección de área
  ];

  # ===== CONFIGURACIÓN DE HYPRLAND =====
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;  # Tu config personalizada

  # ===== SERVICIOS COMPLEMENTARIOS =====
  services = {
    dbus.enable = true;
    gvfs.enable = true;  # Soporte para archivos
    udisks2.enable = true;
  };

  # ===== ENTORNO HÍBRIDO (OPCIONAL) =====
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = lib.mkDefault false;
  };

  # ===== PERMISOS PARA WAYLAND =====
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
