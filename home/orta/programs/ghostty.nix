{ pkgs, ... }:

{
 programs.ghostty = {
    enable = true; # Habilita el módulo de Ghostty

    settings = {
      # Shell: Home Manager sabe cómo manejar las rutas de Nix aquí

      # Tema: Simplemente el nombre del tema
      theme = "Cyberpunk Scarlet Protocol";

      # Fuente: Nombre de la fuente y tamaño
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;

      # Transparencia (opcional): las opciones usan guiones bajos aquí
      background-opacity = 0.70;
    };
  };
}
