{ config, pkgs, inputs, ... }:

{
  imports = [

    ./hardware-configuration.nix

    # Services
    ../../modules/services/audio.nix
    ../../modules/services/network.nix
    ../../modules/services/nvidia.nix

    # Desktops
    ../../modules/desktops
  ];

# ================== Habilitar desktops (cambia según quieras) ====================
  # SE RECOMIENDA: Siemre activar uno solo, aunque puedas activar mas de uno
  # algunos no son compatibles entre si (Ej: Plasma + Niri). Considera de todas maneras
  # que puedes Activar uno u otro con facilidad, por lo que no sera necesario activar
  # más de 2 al mismo tiempo
  desktops = {
    gnome.enable = true;
    #plasma.enable = false;
    # hyprland.enable = false;
    niri.enable = true;
    cosmic.enable = false;
  };

  # Hostname
  networking.hostName = "omen-laptop";

  # Timezone y locale
  time.timeZone = "America/Mexico_City";
  i18n = {
    defaultLocale = "es_MX.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_MX.UTF-8";
      LC_IDENTIFICATION = "es_MX.UTF-8";
      LC_MEASUREMENT = "es_MX.UTF-8";
      LC_MONETARY = "es_MX.UTF-8";
      LC_NAME = "es_MX.UTF-8";
      LC_NUMERIC = "es_MX.UTF-8";
      LC_PAPER = "es_MX.UTF-8";
      LC_TELEPHONE = "es_MX.UTF-8";
      LC_TIME = "es_MX.UTF-8";
    };
  };
  
  # Configuración del teclado (NUEVA SINTÁXIS)
  services.xserver = {
    enable= true;
      xkb = {
        layout = "latam";
        options = "";
      };
   };

  # Para Wayland/consola
  console.keyMap = "la-latin1";  # Para consola TTY
  
  # Touchpad (para laptops)
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
  };


# =============================  Usuario   ====================================
  users.users.orta = {
    isNormalUser = true;
    description = "Christopher Orta";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # Funciones experimentales
  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Paquetes del sistema
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    jq
    helix # Editor de texto moderno
    direnv # Gestión de entornos

    # Terminal
    ghostty

    # CLI Tools
    duf
    eza        # ls moderno con iconos
    ncdu       # analizador de disco interactivo
    btop       # monitor de sistema completo 
    yazi       # file manager TUI
    ripgrep    # grep rápido
    fd         # find mejorado
    zoxide     # cd inteligente
    lazygit    # git TUI
  ];

  # Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # DirenV
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

# ==================== Nix settings con optimizaciones =============================
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0; # Usa todos los cores disponibles
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


# ==================== Configuraciones Extras =============================
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # OpenSSH (opcional)
  # services.openssh.enable = true;

  # Kernel más nuevo para mejor rendimiento
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Optimizaciones de rendimiento
  powerManagement.cpuFreqGovernor = "performance"; # O "schedutil" para balance

  # Zram (compresión de RAM, mejora rendimiento con poca RAM)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  system.stateVersion = "25.11";
}
