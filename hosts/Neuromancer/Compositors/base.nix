{ config, pkgs, lib, ... }:

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
# ======================= Sistema de loggin (SSDM) =====================
  services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";

      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
        };
      };
      extraPackages = with pkgs; [ sddm-astronaut kdePackages.qtmultimedia];
  };

# =============================== Fuentes ==============================
  fonts.fontconfig.enable = true;

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

  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
