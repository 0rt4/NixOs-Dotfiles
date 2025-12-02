{ pkgs, ... }:

{
 programs.ghostty = {
    enable = true; # Habilita el módulo de Ghostty
    
    settings = {
      # Shell: Home Manager sabe cómo manejar las rutas de Nix aquí
      command = "${pkgs.zsh}/bin/zsh";
      
      # Tema: Simplemente el nombre del tema
      #theme = "tokyonight_night";
      
      # Fuente: Nombre de la fuente y tamaño
      font-family = "JetBrains Mono";
      font-size = 12;

      # Transparencia (opcional): las opciones usan guiones bajos aquí
      background-opacity = 0.70;
    };
  };
}
