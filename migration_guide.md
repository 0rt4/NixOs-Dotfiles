# 🔄 Guía de Migración a Flakes

Esta guía te ayudará a migrar tu configuración actual de NixOS a esta estructura basada en flakes.

## Paso 1: Respaldo

```bash
# Respaldar tu configuración actual
sudo cp -r /etc/nixos ~/nixos-backup
```

## Paso 2: Crear la Nueva Estructura

```bash
# Crear el directorio principal
mkdir -p ~/nixos-config
cd ~/nixos-config

# Crear todas las carpetas necesarias
mkdir -p home/Orta
mkdir -p desktops
mkdir -p services
mkdir -p modules/scripts
mkdir -p modules/app-settings
```

## Paso 3: Copiar Hardware Configuration

```bash
# Copiar la configuración de hardware actual
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/
sudo chown $USER:users ~/nixos-config/hardware-configuration.nix
```

## Paso 4: Migrar Paquetes

### De configuration.nix a la nueva estructura:

**Paquetes del sistema** → `configuration.nix`
```nix
# Los paquetes en environment.systemPackages van aquí
```

**Paquetes del usuario** → `home/Orta/pkgs.nix`
```nix
# Los paquetes que usas como usuario van aquí
```

### Identificar qué va dónde:

```nix
# SISTEMA (configuration.nix):
# - Drivers
# - Servicios del sistema
# - Herramientas administrativas
# - Software que necesita permisos root

# USUARIO (home/Orta/pkgs.nix):
# - Navegadores
# - Editores
# - Herramientas de desarrollo
# - Aplicaciones de usuario
```

## Paso 5: Migrar Servicios

Busca en tu `configuration.nix` actual:

```nix
# Configuración de red → services/network.nix
services.xserver = ...
networking = ...
hardware.bluetooth = ...

# Configuración de audio → services/audio.nix
sound.enable = ...
hardware.pulseaudio = ...
services.pipewire = ...

# Configuración de GPU → services/video.nix
hardware.opengl = ...
services.xserver.videoDrivers = ...
```

## Paso 6: Migrar Desktop Environment

Si actualmente usas un DE específico:

```nix
# GNOME → desktops/gnome.nix
services.xserver.desktopManager.gnome.enable = true;

# KDE Plasma → desktops/plasma.nix
services.xserver.desktopManager.plasma5.enable = true;

# Hyprland → desktops/hyprland.nix
programs.hyprland.enable = true;
```

## Paso 7: Personalizar

1. **Edita `flake.nix`:**
   - Cambia el hostname si es necesario
   - Configura qué DEs quieres activos

2. **Edita `configuration.nix`:**
   - Ajusta timezone y locale
   - Configura usuarios
   - Verifica el bootloader

3. **Edita `home/Orta/Orta.nix`:**
   - Cambia el nombre de usuario si es necesario
   - Ajusta tu configuración de Git

4. **Edita `home/Orta/pkgs.nix`:**
   - Añade tus paquetes favoritos
   - Configura tus aliases de shell

## Paso 8: Primera Construcción

```bash
cd ~/nixos-config

# Verificar que el flake es válido
nix flake check

# Primera construcción (usa --impure si hay problemas)
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
```

## Paso 9: Verificación Post-Migración

Después del rebuild, verifica:

```bash
# ✅ Verificar que el sistema arrancó correctamente
systemctl status

# ✅ Verificar servicios de red
nmcli device status

# ✅ Verificar audio
pactl info

# ✅ Verificar que tus aplicaciones funcionan
# Abre tus apps principales

# ✅ Verificar Home Manager
home-manager generations
```

## Paso 10: Limpieza (Opcional)

Una vez que todo funciona:

```bash
# Eliminar generaciones antiguas de la configuración anterior
sudo nix-collect-garbage -d

# Mantener el respaldo por si acaso
# NO borres ~/nixos-backup hasta estar 100% seguro
```

## 🚨 Troubleshooting Común

### Error: "flake.lock not found"
```bash
cd ~/nixos-config
nix flake lock
```

### Error: "attribute missing"
Revisa que todas las importaciones en `flake.nix` apunten a archivos que existen.

### Error: "collision between packages"
Dos paquetes tienen el mismo nombre. Busca duplicados entre `configuration.nix` y `home/Orta/pkgs.nix`.

### El sistema no arranca
1. Reinicia
2. En el menú de boot, selecciona una generación anterior
3. Una vez dentro, revisa los cambios que hiciste

### Home Manager no funciona
```bash
# Rebuild solo de Home Manager
home-manager switch --flake ~/nixos-config#orta
```

## 📋 Checklist de Migración

- [ ] Respaldo creado
- [ ] Estructura de carpetas creada
- [ ] `hardware-configuration.nix` copiado
- [ ] `flake.nix` personalizado (hostname, usuario)
- [ ] `configuration.nix` configurado
- [ ] Paquetes del sistema migrados
- [ ] Paquetes del usuario migrados
- [ ] Servicios migrados
- [ ] Desktop Environment configurado
- [ ] Primera construcción exitosa
- [ ] Sistema verificado y funcionando
- [ ] Scripts de utilidad configurados
- [ ] Aliases configurados

## 🎯 Beneficios de la Nueva Estructura

✅ **Reproducible**: El `flake.lock` congela las versiones
✅ **Modular**: Fácil activar/desactivar componentes
✅ **Organizado**: Cada cosa en su lugar
✅ **Versionable**: Perfecto para Git
✅ **Compartible**: Fácil de usar en múltiples máquinas
✅ **Limpio**: Desactivas un DE y se desinstalan sus dependencias

## 🔄 Próximos Pasos

1. Configura Git en tu directorio de configuración:
```bash
cd ~/nixos-config
git init
git add .
git commit -m "Initial NixOS flake configuration"
```

2. (Opcional) Sube a GitHub para respaldo:
```bash
git remote add origin git@github.com:tu-usuario/nixos-config.git
git push -u origin main
```

3. Explora más opciones en [NixOS Options](https://search.nixos.org/)

4. Únete a la comunidad NixOS para aprender más
