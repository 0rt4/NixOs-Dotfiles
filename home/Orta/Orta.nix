{ config, pkgs, inputs, pkgs-unstable, enabledDesktops, ... }:
{
  # Información básica del usuario
  home.username = "orta";
  home.homeDirectory = "/home/orta";
  home.stateVersion = "25.05";
  
  # Importar paquetes del perfil
  imports = [
    ./pkgs.nix
    ./devtools.nix
    ./app-settings/default.nix
    ./themes/default.nix
    ];
  
  # Permitir que Home Manager maneje el entorno
  programs.home-manager.enable = true;
  
  # Variables de entorno
  home.sessionVariables = {
    EDITOR = "helix";
    SHELL = "${pkgs.zsh}/bin/zsh";
    #QML_IMPORT_PATH = "${pkgs.qml-niri}/lib/qt-6/qml";

  };
  
  # Configuraciones específicas según el DE activo
  home.packages = with pkgs; [
    #unstable.quickshell
  ] 
  ++ (if enabledDesktops.hyprland then [
    # Paquetes específicos para Hyprland
  ] else [])
  ++ (if enabledDesktops.niri then [
  ] else [])
  ++ (if enabledDesktops.gnome then [
  ] else []);
}
