{ config, pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = false;

    extensions = [ 
      # Soporte para lenguajes
      "nix" 
      "toml" 
      "elixir" 
      "make"
      "rust"
      "python"
      "typescript"
      "javascript"
      "json"
      "yaml"
      "markdown"
      "dockerfile"
      "gitignore"
      
      # Temas e iconos
      "tokyo-night"
      "jetbrains-icons"
      
      # Utilidades adicionales
      "error-lens"           # Mejora visualización de errores
      "git-blamer"           # Git blame integrado
      "welcome"              # Pantalla de inicio mejorada
    ];

    userSettings = {
      # -------------------
      # UI y tema - TOKYO NIGHT CLEAR
      # -------------------
      theme = {
        mode = "dark";  # Fuerza modo oscuro para Tokyo Night Clear
        light = "Tokyo Night Day";
        dark = "Tokyo Night Storm";  # ¡El tema que quieres!
      };
      
      # Iconos de JetBrains
      file_icons = "jetbrains-icons";
      
      # Mejoras visuales optimizadas para Tokyo Night Clear
      buffer_font_family = "FiraCode Nerd Font";
      buffer_font_features = {
        calt = true;
        ss01 = true;  # Características tipográficas adicionales
        ss02 = true;
        zero = true;  # Cero con punto
      };
      
      show_whitespaces = "trailing";  # Mejor para múltiples lenguajes
      cursor_blink = false;
      scrollbar = {
        show = "auto";
      };
      
      ui_font_size = 15;
      buffer_font_size = 14;
      line_height = 1.4;

      # -------------------
      # Configuración específica del editor
      # -------------------
      autosave = {
        enabled = true;
        delay = 1000;
      };
      
      code_actions_on_format = {
        source = {
          organizeImports = true;
        };
      };
      
      # -------------------
      # LSP servers PARA MÚLTIPLES LENGUAJES
      # -------------------
      lsp = {
        # Rust
        rust-analyzer = {
          binary.path_lookup = true;
          settings = {
            check.command = "clippy";
            cargo.allFeatures = true;
          };
        };
        
        # Nix
        nix = {
          binary.path_lookup = true;
        };
        
        # Elixir
        elixir-ls = {
          binary.path_lookup = true;
          settings = {
            dialyzerEnabled = true;
            fetchDeps = false;
          };
        };
        
        # Python
        pylsp = {
          binary.path_lookup = true;
          settings = {
            pylsp = {
              plugins = {
                pycodestyle.enabled = true;
                pyflakes.enabled = true;
                pylint.enabled = true;
              };
            };
          };
        };
        
        # TypeScript/JavaScript
        typescript-language-server = {
          binary.path_lookup = true;
          settings = {
            completions = {
              completeFunctionCalls = true;
            };
          };
        };
        
        # Markdown
        marksman = {
          binary.path_lookup = true;
        };
      };

      # -------------------
      # CONFIGURACIÓN POR LENGUAJE
      # -------------------
      languages = {
        # Python
        "Python" = {
          language_servers = [ "pylsp" ];
          format_on_save = {
            external = {
              command = "black";
              arguments = [ "{buffer_path}" ];
            };
          };
          tab_size = 4;
        };

        # Rust
        "Rust" = {
          language_servers = [ "rust-analyzer" ];
          format_on_save = {
            external = {
              command = "rustfmt";
              arguments = [ "{buffer_path}" ];
            };
          };
        };

        # TypeScript/JavaScript
        "TypeScript" = {
          language_servers = [ "typescript-language-server" ];
          format_on_save = {
            external = {
              command = "prettier";
              arguments = [ "--write" "{buffer_path}" ];
            };
          };
        };
        
        "JavaScript" = {
          language_servers = [ "typescript-language-server" ];
          format_on_save = {
            external = {
              command = "prettier";
              arguments = [ "--write" "{buffer_path}" ];
            };
          };
        };

        # Elixir
        "Elixir" = {
          language_servers = [ "elixir-ls" ];
          format_on_save = {
            external = {
              command = "mix";
              arguments = [ "format" "--stdin-filename" "{buffer_path}" "-" ];
            };
          };
        };

        "HEEX" = {
          language_servers = [ "elixir-ls" ];
          format_on_save = {
            external = {
              command = "mix";
              arguments = [ "format" "--stdin-filename" "{buffer_path}" "-" ];
            };
          };
        };
        
        # Nix
        "Nix" = {
          language_servers = [ "nix" ];
          format_on_save = {
            external = {
              command = "nixpkgs-fmt";
              arguments = [ "{buffer_path}" ];
            };
          };
        };
        
        # Markdown
        "Markdown" = {
          language_servers = [ "marksman" ];
          soft_wrap = {
            enabled = true;
          };
        };
        
        # JSON
        "JSON" = {
          format_on_save = {
            external = {
              command = "prettier";
              arguments = [ "--write" "{buffer_path}" ];
            };
          };
        };
        
        # YAML
        "YAML" = {
          format_on_save = {
            external = {
              command = "prettier";
              arguments = [ "--write" "{buffer_path}" ];
            };
          };
        };
      };

      # -------------------
      # Terminal
      # -------------------
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [ ".env" "env" ".venv" "venv" ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "ghostty";
        };
        font_family = "FiraCode Nerd Font";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      # -------------------
      # Otras configuraciones
      # -------------------
      vim_mode = false;
      base_keymap = "VSCode";
      load_direnv = "shell_hook";
      inlay_hints = {
        enabled = true;
        parameter_names = true;
        type_annotations = true;
      };
    };
  };
}
