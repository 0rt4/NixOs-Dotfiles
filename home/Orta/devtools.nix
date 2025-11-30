{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Editores de codigo
      vscode
      helix
      jetbrains.pycharm-community
      jetbrains.webstorm
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

  # Si quieres, puedes habilitar direnv globalmente para todos los proyectos
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
