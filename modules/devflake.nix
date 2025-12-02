{
  description = "Development environments for Python, TypeScript, and Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix.url = "github:nix-community/fenix";
  };

  outputs = { self, nixpkgs, flake-utils, fenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        rust-toolchain = fenix.packages.${system}.stable.toolchain;

      in
      {
      #-------------------------------------------------------------------------------
        devShells = {
          #  Shell POR DEFECTO (Python)
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              python3
              python3Packages.pip
              python3Packages.virtualenv
              #python3Packages.black
              #python3Packages.flake8
              lazygit
            ];
            shellHook = ''
              clear
              # 🔧 CONFIGURACIÓN AUTOMÁTICA (silenciosa)
              if [ ! -d ".venv" ]; then
                python -m venv .venv > /dev/null 2>&1
              fi
              source .venv/bin/activate > /dev/null 2>&1

              if [ -f "requirements.txt" ] && [ ! -d ".venv/lib" ]; then
                pip install -r requirements.txt > /dev/null 2>&1
              fi
              exec $SHELL

              echo "Entorno 󰌠 Python"
              echo "󰌠  python: $(python --version)"
              echo "  pip: $(pip --version)"
              echo ""
              echo "  Comandos de inicio rápido:"
              echo "  pip install -r requirements.txt    # Instalar dependencias"
              echo "  python -m venv .venv              # Crear virtual env"
              echo "  source .venv/bin/activate         # Activar virtual env"
              echo "  pip freeze > requirements.txt     # Guardar dependencias"
              echo "  python manage.py runserver        # Django server"
              echo "  python app.py                     # Ejecutar aplicación"
              echo ""
              echo "  Virtual environment: .venv/"
              echo "  Python path: ./src/"


            '';
            env = {
                PYTHONPATH = "./src:$PYTHONPATH";
                PYTHONDONTWRITEBYTECODE = "1";
            }
          };

          # 󰛦 Shell para TypeScript
          typescript = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs_20
              nodePackages.pnpm
              nodePackages.typescript
              nodePackages.typescript-language-server
              nodePackages.prettier
              nodePackages.nodemon
              lazygit
            ];
            shellHook = ''
              clear
              # 🔧 CONFIGURACIÓN AUTOMÁTICA (silenciosa)
              pnpm config set store-dir ./.pnpm-store > /dev/null 2>&1
              if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
                pnpm install > /dev/null 2>&1
              fi
              exec $SHELL
              echo "Entorno 󰛦 TypeScript"
              echo "  Node: $(node --version)"
              echo "  npm: $(npm --version)"
              echo "󰛦  TypeScript: $(tsc --version)"
              echo ""
              echo "  Comandos de inicio rápido:"
              echo "  pnpm install                      # Instalar dependencias"
              echo "  pnpm dev                          # Modo desarrollo"
              echo "  pnpm build                        # Build producción"
              echo "  pnpm test                         # Ejecutar tests"
              echo "  pnpm add [package]                # Añadir dependencia"
              echo "  pnpm dlx create-react-app my-app  # Crear React app"
              echo "  tsc --watch                       # TypeScript watch"
              echo ""
              echo "  pnpm cache: ./.pnpm-store"
              echo "  Node modules: ./node_modules/"

              #variabes de Entorno
              pnpm config set store-dir ./.pnpm-store
              echo " pnpm cache: ./.pnpm-store"
            '';

            env = {
              NPM_CONFIG_CACHE = "./.npm-cache";
              NEXT_TELEMETRY_DISABLED = "1";
              NIX_SHELL_PRESERVE_PROMPT = "1";
            };
          };

          # 󱘗 Shell para Rust
          rust = pkgs.mkShell {
            buildInputs = with pkgs; [
              lazygit
              cargo
              rustc
              rustfmt
              clippy
            ];
            shellHook = ''
              clear
              # 🔧 CONFIGURACIÓN AUTOMÁTICA (silenciosa)
            if [ ! -f "Cargo.toml" ]; then
              PROJECT_NAME=$(basename "$PWD")
              cargo init --name "$PROJECT_NAME" > /dev/null 2>&1
              echo "✅ Proyecto Rust creado: $PROJECT_NAME"
            else
              echo "✅ Proyecto Rust detectado"
            fi

            if [ ! -d "target" ]; then
              cargo check > /dev/null 2>&1
            fi

              exec $SHELL
              echo "Entorno 󱘗 Rust Activado"
              echo "󱘗  Rust: $(rustc --version)"
              echo "  Cargo: $(cargo --version)"
              echo ""
              echo "  Comandos de inicio rápido:"
              echo "  cargo build                       # Compilar"
              echo "  cargo run                         # Compilar y ejecutar"
              echo "  cargo test                        # Ejecutar tests"
              echo "  cargo check                       # Verificar sin compilar"
              echo "  cargo fmt                         # Formatear código"
              echo "  cargo clippy                      # Linter"
              echo "  cargo add [dependency]            # Añadir dependencia"
              echo "  cargo watch -x run                # Ejecutar al cambiar archivos"
              echo ""
              echo "  Build directory: ./target/"
              echo "󰮄  Rust analyzer: activado"
            '';
            env = {
                RUST_BACKTRACE = "1";
                CARGO_TARGET_DIR = "./target";
            }
          };
        };
      }
    );
}
