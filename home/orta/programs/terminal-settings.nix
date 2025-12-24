{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      # Sistema
      ls = "eza --icons --group-directories-first";
      ll = "eza -lah --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      tree = "eza --tree --icons";

      # Navegación
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Git
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";

      # NixOS
      rebuild-laptop = "/etc/nixos/modules/scripts/rebuild-laptop";
      rebuild-dev = "/etc/nixos/modules/scripts/rebuild-dev";
      rebuild-cybersecurity = "/etc/nixos/modules/scripts/update-cybersecurity";
      
      update-laptop = "/etc/nixos/modules/scripts/update-laptop";
      update-dev = "/etc/nixos/modules/scripts/update-dev";
      update-cybersecurity = "/etc/nixos/modules/scripts/update-cybersecurity";
      
      clean = "/etc/nixos/modules/scripts/clean";
      appdrawer = "/etc/nixos/modules/scripts/appdrawer";
      bgselector = "/etc/nixos/modules/scripts/bgselector";
      colorwaybar = "/etc/nixos/modules/scripts/colorwaybar";
      overviewlistener = "/etc/nixos/modules/scripts/overviewlistener";
      powermenu = "/etc/nixos/modules/scripts/powermenu";
      volumenosd = "/etc/nixos/modules/scripts/volumenosd";

      # Utilidades
      grep = "rg";
      du = "ncdu";
      df = "duf";
      ps = "btop";
    };

    shellInit = ''
      # Deshabilitar el saludo de Fish
      # set -U fish_greeting

      # Configurar PATH
      fish_add_path ~/.local/bin
      fish_add_path ~/.cargo/bin
    '';

    interactiveShellInit = ''
      # Configuración de colores
      set -g fish_color_normal normal
      set -g fish_color_command 81a1c1
      set -g fish_color_quote a3be8c
      set -g fish_color_redirection b48ead
      set -g fish_color_end 88c0d0
      set -g fish_color_error ebcb8b
      set -g fish_color_param eceff4
      set -g fish_color_comment 616e88
      set -g fish_color_match --background=brblue
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_search_match bryellow --background=brblack
      set -g fish_color_history_current --bold
      set -g fish_color_operator 00a6b2
      set -g fish_color_escape 00a6b2
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_valid_path --underline
      set -g fish_color_autosuggestion 4c566a
      set -g fish_color_user brgreen
      set -g fish_color_host normal
      set -g fish_color_cancel -r
      set -g fish_pager_color_completion normal
      set -g fish_pager_color_description B3A06D yellow
      set -g fish_pager_color_prefix white --bold --underline
      set -g fish_pager_color_progress brwhite --background=cyan

      # Keybindings personalizados
      bind \cf 'accept-autosuggestion'
      bind \cH 'backward-kill-word'

      # Inicializar Starship si está disponible
      if type -q starship
        starship init fish | source
      end

      # Inicializar zoxide si está disponible
      if type -q zoxide
        zoxide init fish | source
      end

      # Integración con fzf
      if type -q fzf
        fzf --fish | source
      end
    '';

    functions = {
      mkcd = ''
        mkdir -p $argv[1]
        cd $argv[1]
      '';

      backup = ''
        cp $argv[1] $argv[1].bak
      '';

      extract = ''
        if test -f $argv[1]
          switch $argv[1]
            case '*.tar.bz2'
              tar xjf $argv[1]
            case '*.tar.gz'
              tar xzf $argv[1]
            case '*.bz2'
              bunzip2 $argv[1]
            case '*.rar'
              unrar x $argv[1]
            case '*.gz'
              gunzip $argv[1]
            case '*.tar'
              tar xf $argv[1]
            case '*.tbz2'
              tar xjf $argv[1]
            case '*.tgz'
              tar xzf $argv[1]
            case '*.zip'
              unzip $argv[1]
            case '*.Z'
              uncompress $argv[1]
            case '*.7z'
              7z x $argv[1]
            case '*'
              echo "No sé cómo extraer '$argv[1]'"
          end
        else
          echo "'$argv[1]' no es un archivo válido"
        end
      '';

      fish_greeting = ''
        # Colores
        set -l cyan (set_color -o 7ebae4)
        set -l blue (set_color -o 5277c3)
        set -l gray (set_color 666)
        set -l white (set_color -o white)
        set -l reset (set_color normal)

        # Obtener información del sistema
        set -l kernel (uname -r)
        set -l shell (basename $SHELL)
        set -l de (echo $XDG_CURRENT_DESKTOP)
        
        # Contar número de generaciones (rebuilds)

        echo ""
        echo "  ┌───────────────── $white Hardware $reset ────────────────────┐	┌───────────── $white Software $reset ──────────────┐"
        echo "   $gray 󰻠  CPU:Intel Core i7-9750H CPU @ 2.60GHz       $reset│	 $gray   Kernel:$reset $kernel 	"	
        echo "   $gray 󰘚  GPU:NVIDIA GeForce GTX 1650 Mobile          $reset│	 $gray   Shell:$reset $shell 	"	
        echo "   $blue  $gray Christopher Orta		            $reset│	 $gray 󰢹  DE:$reset $de 		"
        echo "  └─────────────────────────────────────────────────┘	└───────────────────────────────────────┘"
        echo ""
      '';
    };

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];
  };

  # Configuración de Starship (prompt moderno)
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Configuración de zoxide (cd inteligente)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Configuración de fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
