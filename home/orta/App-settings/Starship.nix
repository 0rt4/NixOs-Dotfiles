{ config, pkgs, ... }:

{
  programs.starship = {
    enable =true;
    enableFishIntegration = true;

    settings = {
      # 💡 AJUSTES DE PALETA
      # Foreground: #E4E4E4
      # Rojo Principal (Error/Status): #FF6699
      # Rojo Brillante (Warning/Duración): #FFA3C9
      # Azul Brillante (Estructura/Éxito): #7A8AFF
      # Magenta (Git Branch): #B600B6
      # Azul Oscuro (Directory/Módulos): #0084B6
      # Black Brillante (Fondo Secundario): #372D57

      # Estructura del Prompt (Líneas ╭─ y ╰─)
      format = ''
        [╭─](#7A8AFF)$username $hostname $directory$git_branch$git_status$git_state$cmd_duration
        [│](#7A8AFF)$custom
        [╰─ | ](#7A8AFF)$character
      '';

      # Caracteres de Éxito/Error
      character = {
        success_symbol = "[  ](bold #0084B6)"; 
        error_symbol = "[  ](bold #c93030)"; # Rojo principal para errores
        vicmd_symbol = "[ ](bold #B600B6)"; 
      };

      username = {
        style_user = "bold #00ff66";
        style_root = "bold #c93030"; # Rojo principal para root
        format = "[ 󱄅 ](#7A8AFF)[ $user ]($style)";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        style = "bg:#c93030 fg:#E4E4E4"; 
        format = "[ ](fg:#c93030)[  $hostname ]($style)[ ](fg:#c93030)";
        disabled = false;
      };

      directory = {
        style = "bg:#0099ff fg:#E4E4E4"; 
        format = "[ ](fg:#0099ff)[ $path]($style)[ ](fg:#0099ff)";
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        home_symbol = "";
        read_only = " 󱪨";
        read_only_style = "bg:#FF6699 fg:#E4E4E4"; # Rojo principal para solo lectura
      };

      git_branch = {
        symbol = "";
        style = "bg:#B600B6 fg:#E4E4E4"; # Magenta (destacado)
        format = "[](fg:#B600B6)[ on $symbol$branch ]($style)[](fg:#B600B6)";
      };

      git_status = {
        style = "#FF6699"; # Rojo principal para cambios no staged/conflictos
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        up_to_date = "";
        untracked = "?";
        stashed = "";
        modified = "";
        staged = "[++\($count\)](bold #00CED1)"; # Cyan (ANSI 6) para staged
        renamed = "󰑕";
        deleted = "󰆴";
      };

      git_state = {
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          style = "bold #B600B6"; # Magenta
          rebase = "[ REBASE]($style)";
          merge = "[ MERGE]($style)";
      };

      cmd_duration = {
        min_time = 500;
        # Rojo Brillante/Rosa (FFA3C9) para el icono y Amarillo (FFEB95) para el tiempo
        format = " [](#FFA3C9) [ $duration](bold #FFEB95) ";
        show_milliseconds = false;
      };

      time = {
        disabled = false;
        format = "[](#ff00ff)[$time](bold #00ff9f) ";
        style = "bright-white";
        time_format = "%T";
      };
      
      nix_shell = {
        symbol = "󱄅";
        format = "via [$symbol$state( ($name))]($style) ";
        style = "bold #7A8AFF"; # Azul Brillante
        impure_msg = "[impure](bold #FF6699)"; # Rojo principal
        pure_msg = "[pure](bold #0084B6)"; # Azul oscuro
      };
      
      python = { symbol = ""; format = "via [$symbol$pyenv_prefix($version )]($style)"; style = "#0084B6 bold"; };
      nodejs = { symbol = ""; format = "via [$symbol($version )]($style)"; style = "#0084B6 bold"; };
      rust = { symbol = " "; format = "via [$symbol($version )]($style)"; style = "#0084B6 bold"; };
      docker_context = { symbol = ""; format = "via [$symbol$context]($style) "; style = "#0084B6 bold"; };
      c = { symbol = ""; format = "via [$symbol($version )]($style)"; style = "#0084B6 bold"; };
      golang = { symbol = "󰟓"; format = "via [$symbol($version )]($style)"; style = "#0084B6 bold"; };
      java = { symbol = ""; format = "via [$symbol($version )]($style)"; style = "#0084B6 bold"; };
      lua = { symbol = ""; format = "via [$symbol($version )]($style)"; style = "#0084B6 bold"; };
      package = { symbol = ""; format = "is [$symbol$version]($style) "; style = "#B600B6 bold"; }; 
      aws = { symbol = ""; format = "on [$symbol($profile )]($style)"; style = "#0084B6 bold"; };      
      kubernetes = { symbol = "☸"; format = "on [$symbol$context( ($namespace))]($style) "; style = "#0084B6 bold"; disabled = true; };

      battery = {
        full_symbol = "󰁹"; charging_symbol = "󰂄"; discharging_symbol = "󰁽"; unknown_symbol = "❓"; empty_symbol = "󰁺";
        display = [
          { threshold = 10; style = "bold #FF6699"; } # Rojo principal
          { threshold = 30; style = "bold #FFEB95"; } # Amarillo
        ];
      };

      memory_usage = {
        disabled = false;
        threshold = 75;
        format = "via $symbol[$ram_pct](bold #FF6699) "; # Rojo principal
        symbol = " ";
        style = "bold dimmed white";
      };

      status = {
        style = "bg:#FF6699 fg:#372D57"; # Rojo principal de fondo, Negro Brillante de texto
        symbol = "🔴";
        format = "[\\[$symbol $common_meaning$signal_name$maybe_int\\]]($style) ";
        map_symbol = true;
        disabled = false;
      };
     
      custom.clock = {
	command = "date '+%I:%M %p'";
	when=true;
	format = "[](#7A8AFF)[󰥔 ](fg:#FFA3C9)[$output  ](bold #FFEB95)";
	description = "Hora actual (12h)";
      };
      custom.cpu = {
	  command = "grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf \"%.1f\", usage}'";
	  when = true;
	  format = "[ ](fg:#0099ff)[ $output% ](bold #FFEB95) ";
	  description = "Uso de CPU";
      };
      custom.ram = {
	  command = "free -h | awk '/^Mem:/ {print $3 \"/\" $2}'";
	  when = true;
	  format = "[│](#7A8AFF)[   ](fg:#0099ff)[ $output ](bold #FFEB95) ";
	  description = "Uso de RAM";
      };
      custom.disk = {
	command = "command df -h / | awk 'NR==2 {print $3 \"/\" $2}'";
	when=true;
	format = "[│](#7A8AFF)[  ](fg:#0099ff)[ $output ](bold #FFEB95)";
	description = "Uso de disco raíz";
      };

      line_break = { disabled = false; };
    };
  };
}
