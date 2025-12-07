<<<<<<< Updated upstream
{ config, pkgs, ... }:
=======
{ config, pkgs, lib, ... }:
>>>>>>> Stashed changes

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

# ============================= Configuración ============================
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

  # Sonido (común para todos)
  security.rtkit.enable = true;


# ======================= Sistema de loggin (SSDM) =====================
<<<<<<< Updated upstream
  services.displayManager.sddm = { 
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme"; 
      
=======
  services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";

>>>>>>> Stashed changes
      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
        };
      };
      extraPackages = with pkgs; [ sddm-astronaut kdePackages.qtmultimedia];
  };

# =============================== Fuentes ==============================
  fonts.fontconfig.enable = true;
<<<<<<< Updated upstream
  
=======

>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
# ========================== PKGS PARA LAPTOP ==========================
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
=======
# ========================== PKGS GLOBALES ==========================
  environment.systemPackages = with pkgs; [
    # Tema SDDM
    sddm-astronaut
    kdePackages.qtmultimedia

    # Aplicaciones comunes
    evince
    nautilus
    gparted
    loupe
  ];
}
>>>>>>> Stashed changes
