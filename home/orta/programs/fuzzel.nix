{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    
    settings = {
      main = {
        # Terminal para ejecutar comandos
        terminal = "${pkgs.ghostty}/bin/ghostty";
        
        # Fuente mejorada
        font = "monospace:size=13:weight=medium";
        
        # Modo de lanzador
        dpi-aware = "yes";
        show-actions = "yes";
        prompt = "❯ ";
        icon-theme = "Papirus-Dark";
        layer = "overlay";
        
        # Centrado en pantalla
        anchor = "center";
        horizontal-pad = 40;
        vertical-pad = 20;
        inner-pad = 12;
        
        # Tamaño y apariencia
        lines = 15;
        width = 55;
        tabs = 4;
        icon-size = 32;
      };
      
      colors = {
        # Tema Tokyo Night Storm
        background = "24283bdd";
        text = "c0caf5ff";
        prompt = "7aa2f7ff";
        selection = "3d59a1ff";
        selection-text = "c0caf5ff";
        selection-match = "bb9af7ff";
        match = "7dcfffff";
        border = "7aa2f7ff";
      };
      
      border = {
        width = 2;
        radius = 12;
      };
      
      dmenu = {
        mode = "text";
        exit-immediately-if-empty = "no";
      };
    };
  };
}
