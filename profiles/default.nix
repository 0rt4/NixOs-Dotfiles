{ config, pkgs, lib, ... }:

{
  # Configuraciones que quieres en TODOS los perfiles
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "es_MX.UTF-8";
    
  # Servicios de Xserver
  services.xserver = {
    xkb.layout = "latam"; # Configure keymap in X11
  };
  
  # Configuración de GDM (compartida para todos los entornos)
  services.displayManager.gdm = {
    enable = true;
  };
  
  # ===== Configure console keymap =====
  console.keyMap = "la-latin1";
  
  # ===== DEFINICIÓN DE USUARIOS =====
  users.users.orta = {
    isNormalUser = true;
    description = "Christopher";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "video"     # Para gráficos/aceleración
      "audio"     # Para control de sonido
      "storage"   # Para acceso a discos externos
      "lp"        # Para impresión
      "scanner"   # Para escanear documentos
    ];
    shell = pkgs.zsh;
    # NOTA: Los paquetes específicos por usuario van en Home Manager, no aquí
  };

  # Servicios esenciales
  imports = [
    ../packages/global.nix 
    ../services/audio.nix
    ../services/network.nix
    ../services/video.nix
  ];
}
