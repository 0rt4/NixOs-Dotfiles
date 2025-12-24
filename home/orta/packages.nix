{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
# ====================== Aplicaciones Varias ==============================
    # === Apps ===
      # Agrega más según necesites
      
      # Juegos en terminal
      cataclysm-dda
      (pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
      # NO pongas dfVersion = "0.47.05"; la versión por defecto es más estable para compilar
      theme = pkgs.dwarf-fortress-packages.themes.phoebus;
      enableDFHack = true;
        })
    ];
}

