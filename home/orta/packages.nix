{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
# ====================== Aplicaciones Varias ==============================
      # Apps
        steam
        #telegram-desktop

        #spicetify-cli
        #spotify
        #obsidian
        #stremio

      # Navegadores
        google-chrome
        bitwarden-desktop
        unstable.zen-browser
        #librewolf-bin
      # Agrega más según necesites

# ======================      Desarrollo     ===================================
      # IDES
        vscode
        #jetbrains.pycharm-community
        #jetbrains.webstorm
        github-desktop
        #gitkraken

      # 🐍 Python
        #python3
        #python3Packages.python-lsp-server

      # 🦀 Rust
        #rustup

      # 📜 JavaScript / TypeScript
        #nodejs
        #typescript
        #typescript-language-server
    ];
}

