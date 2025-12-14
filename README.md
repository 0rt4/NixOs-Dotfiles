# Dotfiles NixOS

**Hola**, este proyecto representa mi viaje por **NixOS**. Un sistema operativo completamente reproducible, declarativo y personalizado que se adapta a mis necesidades de desarrollo y flujo de trabajo diario como programador.

Esta es mi configuración personal y a sido diseñada de manera **modular**, pensando en distribuir adecuadamente las responsabilidades por secciones (separation of concerns) y así lograr un código **mantenible a largo plazo**.

# Arquitectura del Proyecto

```
NIXOS-DOTFILES/
├── home/orta/
│ ├── programs/
│ ├── themes/
│ │ ├── Cursor.nix
│ │ ├── default.nix
│ │ ├── GTK.nix
│ │ └── QT.nix
│ ├── default.nix
│ └── packages.nix
├── hosts/laptop/
│ ├── default.nix
│ └── hardware-configur...
├── modules/
│ ├── desktops/
│ │ ├── base.nix
│ │ ├── cosmic.nix
│ │ ├── default.nix
│ │ ├── gnome.nix
│ │ ├── kde-plasma.nix
│ │ └── niri.nix
│ ├── scripts
│ └── services
├── devflake.nix
├── flake.lock
└── flake.nix
```

## Decisiones de Diseño

La lógica detrás de esta estructura de directorios se basa en la modularidad y la separación clara de responsabilidades:

### `home/`

Este directorio centraliza las configuraciones individuales (declarativas) de cada usuario. Se subdivide de la siguiente manera:

*   **`programs/`**: Contiene las **declaraciones** específicas para cada aplicación de forma individual.
*   **`themes/`**: Gestiona la **configuración** de temas por usuario, incluyendo ajustes de **cursor** e **iconos** para diversas aplicaciones.

Adicionalmente, los archivos principales dentro de `home/` definen el alcance general del usuario:

*   **`default.nix`**: Define la **configuración** global del usuario.
*   **`packages.nix`**: Lista los programas instalados específicos para ese usuario.

~**(Considere estas como un ejemplo de como distribuir las configuraciones)**~


### `hosts/`

Aquí se encuentran las **declaraciones** específicas para cada equipo físico (host), permitiendo una granularidad detallada según el hardware:

*   Alberga configuraciones optimizadas basadas en las especificaciones de cada máquina.
*   Incluye el archivo `hardware-configuration.nix` generado automáticamente por NixOS para ese dispositivo específico.

### `modules/`

Este directorio agrupa componentes reusables y configuraciones de sistema compartidas:

*   **`desktops/`**: **Declara** las configuraciones de entornos de escritorio (GNOME, KDE Plasma, etc.) que pueden activarse a gusto del usuario.
*   **`scripts/`**: Almacena scripts para la terminal.
*   **`services/`**: Contiene las **declaraciones** precisas para servicios del sistema como el **audio**, la **red**, **drivers** diversos, entre otros.

### `flake.nix` y `flake.lock`

Estos archivos gestionan las dependencias globales y la **configuración** base necesaria para que todo el sistema funcione de manera reproducible. También permiten la **inclusión de aplicaciones que no se encuentran en los repositorios principales de Nixpkgs** mediante el uso de *flakes* de terceros.

## ¿Por qué esta estructura y no otra?

Después de probar varias aproximaciones (archivo monolítico con el que comencé, estructuras planas, entre otras.), esta organización ha demostrado ser la más **escalable y mantenible**. Permite:

    1.- Reutilización: Los módulos pueden compartirse entre hosts

    2.- Claridad: Es fácil encontrar dónde modificar algo

    3.- Pruebas: Se pueden habilitar/deshabilitar componentes individualmente

## ¿Cómo empiezo a usar esta configuración?

    Clona el repositorio en /etc/nixos o en tu home (con enlaces simbólicos)

    Ajusta hosts/ para tu hardware específico

    Personaliza home/ con tus programas y temas preferidos

    Ejecuta sudo nixos-rebuild switch --flake .#nombre-del-host

## ¿Qué pasa si soy nuevo en NixOS?

Esta configuración es avanzada pero está diseñada para ser comprensible. Te recomiendo:

    Familiarizarte con los conceptos básicos de NixOS

    Explorar un módulo a la vez

    Modificar gradualmente en lugar de cambiar todo de una vez

## ¿Cómo agrego un nuevo programa?

La primera duda que puede surgir es donde declarar tus aplicaciones/programas/librerias. El donde declararlas depende del alcance:

    - Para un equipo en particular: Agrégalo en el host correspondiente (drivers especificos pueden ser colocados en modules/services)

    - Dependiendo del Desktop Enviroment Habilitado: En su respectivo archivo de configuracion en modules/desktops/desktop.nix

    - Para un usuario específico: Agrégalo en home/usuario/packages.nix

    - Declarar una configuración personalizada: Crea un archivo en home/usuario/programs/

    - Las fuentes son consideradas globales para todas las DE que habilites por lo que puedes declararlas en modules/desktops/base.nix

## ¿Por qué NixOs?

    - Reproducibilidad: Reconstruye exactamente el mismo sistema en cualquier momento

    - Rollbacks seguros: Si algo falla, vuelve a la configuración anterior con un reinicio

    - Portabilidad: Fácil migración entre diferentes máquinas

    - Transparencia: Todo está versionado y documentado

    - Precisión: Evita el dependenci hell y se puede declarar de manera precisa lo necesario


## 🤝 Contribuciones y Adaptación

Siéntete libre de forkear este repositorio y adaptarlo a tus necesidades. La belleza de NixOS está en su personalización, y esta estructura es solo un punto de partida. Cada usuario tiene flujos de trabajo únicos, y el sistema debería adaptarse a ellos, no al revés.

---

*Esta configuración está en constante evolución. Lo que hoy es un módulo separado, mañana podría integrarse mejor, ya que este **Dotfile** crece junto a mi como programador, aplicando mejores practicas que personalmente vaya aprendiendo. Sin embargo, siempre se buscará priorizar el mantener la claridad y la capacidad de mantenimiento a largo plazo.*

*La rama main siempre tratará de tener la configuración estandar, por lo que no deberia preocuparte si añado configuraciones personales más alla de las ya establecidas, que he dejado como plantilla tanto como para mi como para quien lo forkeé lo pueda usar como ejemplo*
