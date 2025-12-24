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
  # SE RECOMIENDA: Siempre activar uno solo, aunque puedas activar mas de uno
  # algunos no son compatibles entre si (Ej: Plasma + Niri). Considera de todas maneras
  # que puedes Activar uno u otro con facilidad, por lo que no sera necesario activar
  # más de 2 al mismo tiempo
  desktops = {
    gnome.enable = false;
    # plasma.enable = false;
    # hyprland.enable = false;
    niri.enable = false;
    mangowc.enable = true;
  };

  # Hostname
  networking.hostName = "syntek-dev";

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
    description = "syntek-dev";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # Funciones experimentales
  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Paquetes del sistema
  environment.systemPackages = with pkgs; [

  # === CLI Tools ===
    direnv # Gestión de entornos
    
  # === Aplicaciones extras ===
    evince
    gparted
    loupe
    mpv
    nautilus

    bitwarden-desktop
    unstable.zen-browser
    
  # === Desarrollo  ===
  
    # Herramientas
    jetbrains.pycharm
    jetbrains.webstorm
    vscode
    
    github-desktop
    #gitkraken
  
  # === Dependencias y lenguajes ===
    
    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv
    
    # Typescript
    nodejs_20
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.nodemon
    
    # Rust
    #cargo
    #rustc
    #rustfmt
    #clippy
  
  ];

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
      options = "--delete-older-than 3d";
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
