{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
      # Desarrollo
        vscode
        jetbrains.pycharm-community
        jetbrains.webstorm
        github-desktop
        # gitkraken
      
      # 🐍 Python
        #python3
        #python3Packages.python-lsp-server

      # 🦀 Rust
        #rustup

      # 📜 JavaScript / TypeScript
        #nodejs
        #typescript
        #typescript-language-server

# ====================================================
      
      # Apps
        steam
      #  telegram-desktop
        nautilus
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
    ];
}