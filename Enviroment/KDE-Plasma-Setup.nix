{ pkgs, ... }:

{
  # ===== SOLO CONFIGURACIONES ESPECÍFICAS DE PLASMA =====
  # (Sin gestión de display managers)

  # Paquetes para excluir de Plasma
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];

  # Paquetes adicionales para KDE
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin-plugins
    kdePackages.kate
  ];

  # Integración esencial (opcional)
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
}
