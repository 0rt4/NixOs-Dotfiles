{ config, ... }:

{
  # Importación de Configuraciones
  imports = [
    ./hardware-configuration.nix

    ./services/audio.nix
    ./services/network.nix
    ./services/video.nix

    ./profiles/gnome.nix    # Para GNOME
    ./profiles/hyprland.nix # Para Hyprland
  ];

  # ====================== CONFIGURACIONES INDISPENSABLES PARA FUNCIONAR EL SISTEMA ==================
  
  users.users.orta = {
    isNormalUser = true;
    description = "Christopher";
    extraGroups = [ 
      "networkmanager"     # Gestionar conexiones de red
      "wheel"              # Permisos de administrador
      "video"              # Acceso a configuraciones de gráficos/aceleración
      "audio"              # Control de dispositivos de sonido
      "storage"            # Acceso a discos externos
      "lp"                 # Permisos de impresión
      "scanner"            # Permisos para escanear documentos
    ];
    shell = pkgs.zsh;
  };

  # ====================== REGION Y LENGUAJE ======================

  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "es_MX.UTF-8";
  
  services.xserver.xkb.layout = "latam"; # Configurar Distribución de Teclado en X11
  console.keyMap = "la-latin1"; # Configurar Distribución de Teclado en Consola

  services.displayManager.gdm.enable = true; #Display Manager

  # ===============CONFIGURACIONES EXPERIMENTALES=================

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nixpkgs.config.allowUnfree = true;
  
  programs.zsh.enable = true;

  # Configuración de Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Abrir Puertos Predeterminados en el Firewall para Syncthing
  };

  # Configuración de Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Abrir Puertos en el Firewall para Steam Remote Play
    dedicatedServer.openFirewall = true; # Abrir Puertos en el Firewall para Servidor Dedicado de Source
  };
  
  # Servicio CUPS para Impresoras
  services.printing.enable = false;

  # ======================== BOOTLOADER ==========================

  boot.loader = {
    systemd-boot.enable = true;
    canTouchEfiVariables = true;
  };

  # =============== CARACTERISTICAS DEL SISTEMA OPERATIVO =================
  
  networking.hostName = "nixos";
  system.stateVersion = "25.05";
}
