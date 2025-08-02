{ lib, pkgs, ... }:

{
  # ===== Configuración específica para GNOME =====
  # (Asume que GDM ya está activado desde desktop-environments.nix)

  # Extensiones GNOME (las que se instalan globalmente)
  environment.gnome.excludePackages = with pkgs; [
    cheese
    gnome-connections
    seahorse
    gnome-music
    epiphany
    gnome-tour
    gnome-shell-extensions   # Excluye la app nativa (usamos extension-manager)
  ];

  # Paquetes y extensiones (instalación global)
  environment.systemPackages = with pkgs; [
    # Herramientas esenciales
    gnome-tweaks
    gnome-extension-manager  # Alternativa mejorada a gnome-extensions-app

    # Extensiones (instalación manual desde el manager luego)
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    gnomeExtensions.gsconnect
    gnomeExtensions.openweather-refined
    gnomeExtensions.forge
    gnomeExtensions.fuzzy-app-search
    gnomeExtensions.app-menu-is-back
    gnomeExtensions.open-bar
    gnomeExtensions.tiling-shell
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.search-light
    gnomeExtensions.burn-my-windows
  ];

  # ===== Optimizaciones específicas para GNOME =====
  services = {
    dbus.packages = [ pkgs.gcr ];  # Necesario para GNOME Keyring
    gnome = {
      core-developer-tools.enable = true;  # Herramientas para desarrolladores
      core-apps.enable = false;       # Desactiva apps no deseadas
    };
  };
}
