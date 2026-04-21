{ config, pkgs, inputs, lib,... }: 

{
  imports = [
    inputs.illogical-flake.homeManagerModules.default 
  ];

  # Mantenemos esto para evitar conflictos con el starship base de Home Manager
  programs.starship.enable = lib.mkForce false;
  
  programs.illogical-impulse = {
    enable = true;
    
    dotfiles = {
      fish.enable = true;
      kitty.enable = true;
      starship.enable = true; 
    };
    
    # Mantenemos los plugins comentados hasta que el sistema base funcione
    # hyprland.plugins = [
    #   pkgs.hyprlandPlugins.hyprbars
    #   pkgs.hyprlandPlugins.hyprexpo
    # ];
  };
}
