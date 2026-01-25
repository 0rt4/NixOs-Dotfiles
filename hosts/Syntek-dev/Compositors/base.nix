{ config, pkgs, lib, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
     themeConfig = {
    #   AccentColor = "#746385";
       Background = "${../../../modules/scripts/wallpaper-sddm.jpg}";
    #   FormPosition = "left";
    #
    #   ForceHideCompletePassword = true;
    #   Font = "FiraCode Nerd Font";
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

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    # Usamos mkForce para ganar la "pelea" contra el módulo de Mango
    config.mango.default = lib.mkForce [ "wlr" "gtk" ];
    
    # También es buena idea asegurar el genérico por si acaso
    config.common.default = lib.mkForce [ "gtk" ];
    
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
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
