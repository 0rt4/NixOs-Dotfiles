{ config, pkgs, lib, ... }:

{
  programs.helix = {
    enable = true;
    
    settings = {
      theme = "nuevo";
      
      editor = {
				color-modes = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        
        line-number = "relative";
        mouse = false;
        indent-guides.render = true;
        bufferline = "multiple";
        statusline = {
          left = ["mode" "spinner"];
          center = ["file-name"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" "version-control"];
          separator = "│";
					mode = {
		        normal = "NORMAL";
		        insert = "INSERT";
		        select = "SELECT";
		      };
        };
      };
      
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "C-s" = ":w";
      };
    };
    
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        }
        {
          name = "python";
          auto-format = true;
          formatter.command = "${pkgs.black}/bin/black";
          formatter.args = ["--quiet" "-"];
        }
        {
          name = "javascript";
          auto-format = true;
          formatter.command = "${pkgs.nodePackages.prettier}/bin/prettier";
          formatter.args = ["--stdin-filepath" "filename"];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter.command = "${pkgs.nodePackages.prettier}/bin/prettier";
          formatter.args = ["--stdin-filepath" "filename"];
        }
        {
          name = "json";
          auto-format = true;
          formatter.command = "${pkgs.nodePackages.prettier}/bin/prettier";
          formatter.args = ["--stdin-filepath" "filename"];
        }
        {
          name = "html";
          auto-format = true;
          formatter.command = "${pkgs.nodePackages.prettier}/bin/prettier";
          formatter.args = ["--stdin-filepath" "filename"];
        }
        {
          name = "css";
          auto-format = true;
          formatter.command = "${pkgs.nodePackages.prettier}/bin/prettier";
          formatter.args = ["--stdin-filepath" "filename"];
        }
        {
          name = "markdown";
          auto-format = true;
          formatter.command = "${pkgs.nodePackages.prettier}/bin/prettier";
          formatter.args = ["--stdin-filepath" "filename"];
        }
        {
          name = "yaml";
          auto-format = true;
          formatter.command = "${pkgs.yamlfmt}/bin/yamlfmt";
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = "${pkgs.rustfmt}/bin/rustfmt";
        }
        {
          name = "bash";
          auto-format = true;
          formatter.command = "${pkgs.shfmt}/bin/shfmt";
        }
      ];
      
      language-server = {
        pylsp = {
          command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
        };
        typescript-language-server = {
          command = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
        };
        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        };
      };
    };
    
    themes = {
      ayu_dark_transparent = {
        inherits = "ayu_dark";
        "ui.background" = { };
      };
      
      nuevo = {
        # ========== INTERFAZ PRINCIPAL ==========
        "ui.text" = "#c0caf5";
        "ui.text.focus" = "#ffffff";
    			"ui.background" = { bg = "#1a1b26"; };
    			"ui.background.separator" = "#2a2b3c";
				"ui.virtual" = "#565f89";
				"ui.virtual.ruler" = "#414868";
				"ui.virtual.indent-guide" = "#414868";
				"ui.virtual.inlay-hint" = "#737aa2";
        
        # ========== BARRA DE ESTADO Y MODOS ==========
    			"ui.statusline" = { bg = "#16161e"; fg = "#787c99"; };
    			"ui.statusline.normal" = { bg = "#7aa2f7"; fg = "#1a1b26"; modifiers = ["bold"]; };
    			"ui.statusline.insert" = { bg = "#9ece6a"; fg = "#1a1b26"; modifiers = ["bold"]; };
    			"ui.statusline.select" = { bg = "#ff9e64"; fg = "#1a1b26"; modifiers = ["bold"]; };
    			"ui.statusline.separator" = "#3b4261";

				# ========== BARRA DE BUFFER ==========
				"ui.bufferline" = { bg = "#16161e"; fg = "#565f89"; };
				"ui.bufferline.active" = { fg = "#7aa2f7"; modifiers = ["bold"]; };
				"ui.bufferline.background" = { bg = "#16161e"; };
        
				# ========== SELECCIÓN Y CURSOR ==========
				"ui.selection" = { bg = "#2e3f64"; };
				"ui.selection.primary" = { bg = "#3d59a1"; };
				"ui.cursor" = { bg = "#c0caf5"; };
				"ui.cursor.match" = { bg = "#33467c"; modifiers = ["underlined"]; };
				"ui.cursor.primary" = { bg = "#c0caf5"; };
        
				# ========== NÚMEROS DE LÍNEA ==========
				"ui.linenumber" = "#565f89";
				"ui.linenumber.selected" = "#c0caf5";
				"ui.linenumber.highlight" = "#737aa2";
				"ui.linenumber.cursor" = "#7aa2f7";
        
				# ========== MENÚS Y POPUPS ==========
				"ui.menu" = { bg = "#1a1b26"; fg = "#c0caf5"; };
				"ui.menu.selected" = { bg = "#2e3f64"; fg = "#ffffff"; };
				"ui.menu.scroll" = { bg = "#16161e"; fg = "#737aa2"; };
				"ui.help" = { bg = "#1a1b26"; fg = "#c0caf5"; };
				"ui.popup" = { bg = "#1a1b26"; fg = "#c0caf5"; };
				"ui.window" = { bg = "#16161e"; };

				# ========== SINTAXIS - COLORES PRINCIPALES ==========
				"keyword" = { fg = "#bb9af7"; modifiers = ["bold"]; };
				"function" = { fg = "#7dcfff"; };
				"function.builtin" = { fg = "#7aa2f7"; };
				"function.call" = { fg = "#7dcfff"; };
				"type" = { fg = "#2ac3de"; };
				"type.builtin" = { fg = "#7aa2f7"; };
				"variable" = "#c0caf5";
				"variable.builtin" = "#ff9e64";
				"variable.parameter" = "#e0af68";
				
				# ========== SINTAXIS - STRINGS Y TEXTOS ==========
				"string" = { fg = "#9ece6a"; };
				"string.special" = { fg = "#89ddff"; };
				"character" = { fg = "#e0af68"; };
				"comment" = { fg = "#565f89"; };
				
				# ========== SINTAXIS - CONSTANTES Y NÚMEROS ==========
				"constant" = { fg = "#ff9e64"; };
				"constant.builtin" = { fg = "#ff9e64"; modifiers = ["bold"]; };
				"constant.numeric" = { fg = "#ff9e64"; };
				"constant.character" = { fg = "#e0af68"; };
				
				# ========== SINTAXIS - OPERADORES Y PUNTUACIÓN ==========
				"operator" = { fg = "#89ddff"; };
				"punctuation" = { fg = "#c0caf5"; };
				"punctuation.delimiter" = { fg = "#89ddff"; };
				"punctuation.bracket" = { fg = "#c0caf5"; };
				
				# ========== SINTAXIS - ESTRUCTURAS ESPECIALES ==========
				"tag" = { fg = "#f7768e"; };
				"attribute" = { fg = "#e0af68"; };
				"namespace" = { fg = "#bb9af7"; };
				
				# ========== DIAGNÓSTICOS Y ERRORES ==========
				"diagnostic" = { modifiers = ["underlined"]; };
				"diagnostic.error" = { fg = "#f7768e"; underline = { color = "#f7768e"; style = "line"; }; };
				"diagnostic.warning" = { fg = "#e0af68"; underline = { color = "#e0af68"; style = "line"; }; };
				"diagnostic.info" = { fg = "#7dcfff"; underline = { color = "#7dcfff"; style = "line"; }; };
				"diagnostic.hint" = { fg = "#73daca"; underline = { color = "#73daca"; style = "line"; }; };
				
				# ========== DIFERENCIAS Y VERSIONADO ==========
				"diff.plus" = "#41a6b5";
				"diff.minus" = "#f7768e";
				"diff.delta" = "#e0af68";
				
				# ========== MARCADORES Y MARCADOS ==========
				"markup.heading" = { fg = "#7aa2f7"; modifiers = ["bold"]; };
				"markup.list" = { fg = "#bb9af7"; };
				"markup.bold" = { modifiers = ["bold"]; };
				"markup.italic" = { modifiers = ["italic"]; };
				"markup.link" = { fg = "#7dcfff"; modifiers = ["underlined"]; };
				"markup.raw" = { fg = "#9ece6a"; };
				
				# ========== ELEMENTOS DE INTERFAZ ADICIONALES ==========
				"ui.highlight" = { bg = "#292e42"; };
				"ui.text.info" = "#7aa2f7";
				"ui.text.warn" = "#e0af68";
				"ui.text.error" = "#f7768e";
				"ui.gutter" = { bg = "#1a1b26"; };
				"ui.cursorline.primary" = { bg = "#16161e"; };
      };
    };
  };

  # Asegurar que las dependencias estén instaladas
  home.packages = with pkgs; [
    nixfmt-classic
    black
    shfmt
    yamlfmt
  ];
}
