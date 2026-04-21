{ config, pkgs, inputs, lib, ... }:

{
  networking.hostName = "NixOs-Laptop";
  system.stateVersion = "25.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

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
      "nvme_core.default_ps_state=0"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
      "intel_iommu=on"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10; # Evita usar swap innecesariamente
      "vm.vfs_cache_pressure" = 50; # Mantiene el caché de archivos más tiempo
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
    defaultLocale = "de_DE.UTF-8";
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

  # =============================  Usuario   ====================================
  users.users.orta = {
    isNormalUser = true;
    description = "Christopher Orta";
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
}
