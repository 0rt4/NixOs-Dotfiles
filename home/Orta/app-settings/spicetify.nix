{ config, pkgs, inputs, ... }:

{
  # Necesitas agregar spicetify-nix a tus inputs en flake.nix
  # spicetify-nix.url = "github:the-argus/spicetify-nix";
  
  # Configuración de Spicetify para personalizar Spotify
  # Descomenta y configura cuando añadas el input
  
  # imports = [ inputs.spicetify-nix.homeManagerModule ];
  
  # programs.spicetify = {
  #   enable = true;
  #   theme = "catppuccin-mocha";
  #   colorScheme = "mocha";
  #   
  #   enabledExtensions = with inputs.spicetify-nix.extensions; [
  #     adblock
  #     hidePodcasts
  #     shuffle
  #   ];
  #   
  #   enabledCustomApps = with inputs.spicetify-nix.apps; [
  #     newReleases
  #     lyrics-plus
  #   ];
  # };

  # Por ahora, solo aseguramos que Spotify esté instalado
  home.packages = with pkgs; [
    #spotify
  ];
}
