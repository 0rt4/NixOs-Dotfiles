{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
<<<<<<< Updated upstream:home/orta/packages.nix
# ====================== Aplicaciones Varias ==============================  
      # Apps
        steam
      #  telegram-desktop
        nautilus
=======
# ====================== Aplicaciones Varias ==============================
      # Apps
        steam
        #telegram-desktop

>>>>>>> Stashed changes:home/Orta/packages.nix
        #spicetify-cli
        #spotify
        #obsidian
        #stremio
<<<<<<< Updated upstream:home/orta/packages.nix
      
=======

>>>>>>> Stashed changes:home/Orta/packages.nix
      # Navegadores
        google-chrome
        bitwarden-desktop
        unstable.zen-browser
        #librewolf-bin
      # Agrega más según necesites

# ======================      Desarrollo     ===================================
      # IDES
        vscode
<<<<<<< Updated upstream:home/orta/packages.nix
        jetbrains.pycharm-community
        jetbrains.webstorm
        github-desktop
        #gitkraken
      
=======
        #jetbrains.pycharm-community
        #jetbrains.webstorm
        github-desktop
        #gitkraken

>>>>>>> Stashed changes:home/Orta/packages.nix
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
<<<<<<< Updated upstream:home/orta/packages.nix
}
=======
}

>>>>>>> Stashed changes:home/Orta/packages.nix
