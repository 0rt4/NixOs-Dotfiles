{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Componentes esenciales de Hyprland
    hyprland
    waybar
    rofi-wayland
    swaylock-effects
    
    # Herramientas de utilidad
    wl-clipboard  # Portapapeles
    grim          # Capturas de pantalla
    slurp         # Selección de área
    mako          # Notificaciones
    
    # Aplicaciones recomendadas
    #kitty         # Terminal
    #firefox-wayland  # Navegador
    nwg-launchers # Lanzadores adicionales
  ];
}
