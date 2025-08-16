{ config, ... }:

{
  # Selecciona UNO de estos perfiles:
  imports = [
    ./hardware-configuration.nix
    ./profiles/gnome.nix    # Para GNOME
    #./profiles/hyprland.nix # Para Hyprland
  ];

  # ======================== Bootloader ==========================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #===============Configuraciones Experimentales =================
  programs.zsh.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   

  #=============== Caracteriticas del OS =================
  networking.hostName = "nixos";
  system.stateVersion = "25.05";
}
