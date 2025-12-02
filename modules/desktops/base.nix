{ config, pkgs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
     themeConfig = {
    #   AccentColor = "#746385";
    #   Background = "path/to/background.jpg";
    #   FormPosition = "left";
    #
    #   ForceHideCompletePassword = true;
    #   Font = config.stylix.fonts.sansSerif.name;
     };
  };
in
{
  # Configuración común para todos los desktops
    programs.xwayland.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "latam";
      variant = "";
    };
  };

  services.displayManager.sddm = { 
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme"; 
      
      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
        };
      };
      extraPackages = with pkgs; [ sddm-astronaut kdePackages.qtmultimedia];
  };

  # Fuentes
  fonts.packages = with pkgs; [
    # Nerd Fonts individuales
    nerd-fonts.ubuntu
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.meslo-lg

    # Otras fuentes
    jetbrains-mono  # Versión estándar, no nerd font
    rubik
    inter
  ];

  # Sonido (común para todos)
  security.rtkit.enable = true;

  # Paquetes básicos para todos
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}