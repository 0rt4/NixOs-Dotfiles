{ config, pkgs, lib, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
     themeConfig = {
       Background = "${../../../modules/scripts/wallpaper-sddm.jpg}";
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
    config.mango.default = lib.mkForce [ "wlr" "gtk" ];
    
    # También es buena idea asegurar el genérico por si acaso
    #config.common.default = lib.mkForce [ "gtk" ];
    
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  # =============================== Fuentes ==============================
  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    # 1. Iconos de Sistema:
    nerd-fonts.ubuntu
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    #nerd-fonts.hack
    #nerd-fonts.meslo-lg

    # Phosphor Icons
    (pkgs.stdenv.mkDerivation {
      pname = "phosphor-icons-ttf";
      version = "2.1.1";
      src = pkgs.fetchFromGitHub {
        owner = "phosphor-icons";
        repo = "web";
        rev = "v2.1.1";
        hash = "sha256-Ul0UtnsrJ4pUY+rozU7W6DIpIq7DstQN69sOql4x6Yc=";
      };
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        find src -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
      '';
    })
    (google-fonts.override { fonts = [ "Inter"]; })
  ];
  
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
