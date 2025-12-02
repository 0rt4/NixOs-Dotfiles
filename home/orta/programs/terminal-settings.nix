{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = false;
  
    shellAliases = {
      ll = "eza -la";
      rebuild = "/etc/nixos/modules/scripts/rebuild.sh";
      update = "/etc/nixos/modules/scripts/update.sh";
      clean = "/etc/nixos/modules/scripts/clean.sh";
      appdrawer = "/etc/nixos/modules/scripts/appdrawer";
      bgselector = "/etc/nixos/modules/scripts/bgselector";
      colorwaybar = "/etc/nixos/modules/scripts/colorwaybar";
      overviewlistener = "/etc/nixos/modules/scripts/overviewlistener";
      powermenu = "/etc/nixos/modules/scripts/powermenu";
      volumenosd = "/etc/nixos/modules/scripts/volumenosd";
      
      # Aliases para Yazi y Helix
      yz = "cd \"\$(yazi --cwd-file)\"";
      yh = "yazi";
    };
  
    initContent = ''
      # Configurar Helix como editor por defecto
      export EDITOR="helix"
      export VISUAL="helix"
      
      # Cargar Powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      
      # Ejecutar Fastfetch al iniciar la terminal (si está instalado)
      if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
      fi
    '';
  };
}
