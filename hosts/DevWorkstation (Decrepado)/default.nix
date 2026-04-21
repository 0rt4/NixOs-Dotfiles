{ config, pkgs, inputs, lib, ... }:

{
  networking.hostName = "devWorkstation-ORTA";
  system.stateVersion = "25.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot = {
    # Usar el kernel Zen para mejor latencia
    kernelPackages = pkgs.linuxPackages_zen;

    # Parámetros para arranque rápido y silencioso
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "processor.max_cstate=1"
      "transparent_hugepage=madvise"
      "nowatchdog"
    ];

    # Optimización de latencia en el sistema de archivos
    kernel.sysctl = {
      "vm.swappiness" = 10; # Evita usar swap innecesariamente
      "vm.vfs_cache_pressure" = 50; # Mantiene el caché de archivos más tiempo
      "kernel.sched_migration_cost_ns" = 5000000;
      "kernel.sched_latency_ns" = 10000000;
      "kernel.sched_autogroup_enabled" = 1;
    };
  };

  imports = [
    ./Hardware-configuration.nix
    ./Services
    ./Compositors
    #./Shell.nix
    ./Packages.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  time.timeZone = "America/Mexico_City";
  i18n = {
    defaultLocale = "en_US.UTF-8";
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

  services.xserver = {
    enable = true;
    xkb = {
      layout = "latam";
      options = "";
    };
  };

  console.keyMap = "la-latin1";

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
    description = "Dev Workstation ORTA";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users.orta = { inputs, ... }: { imports = [ ../../home/orta ]; };
  };

  # Funciones experimentales
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  #  security.polkit.enable = true;
}
