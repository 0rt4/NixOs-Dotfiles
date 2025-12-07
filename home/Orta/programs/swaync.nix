{config, pkgs, ...}: {
  services.swaync = {
    enable = true;
    
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-width = 420;
      notification-window-width = 420;
      keyboard-shortcuts = true;
      image-visibility = "always";
      transition-time = 250;
      hide-on-clear = true;
      hide-on-action = true;
      fit-to-screen = false;

      # Tiempos optimizados
      timeout = 8;
      timeout-low = 4;
      timeout-critical = 0;

      # Widgets con estilo
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
        "mpris"
        "volume"
      ];

      widget-config = {
        title = {
          text = "󱓥 Notificaciones";
          clear-all-button = true;
          button-text = "󰅖 Limpiar Todo";
        };
        mpris = {
          image-size = 80;
          image-radius = 12;
        };
        volume = {
          label = "󰕾";
        };
        dnd = {
          text = "󰂛 No Molestar";
        };
        inhibitors = {
          text = "󰅖 Inhibidores";
        };
      };
    };

    # 🎨 CSS ULTRA-MODERNO - Compatible con v0.11.0
    style = ''
      /* Tema Neo-Futurista */
      * {
        font-family: "JetBrainsMono Nerd Font", "SF Pro Display", sans-serif;
        font-size: 13px;
        font-weight: 500;
      }

      /* Fondo con gradiente animado */
      .control-center {
        background: transparent;
        border: none;
      }

      .widget-box {
        background: linear-gradient(135deg, 
          rgba(25, 25, 45, 0.98) 0%,
          rgba(35, 35, 60, 0.95) 50%,
          rgba(25, 25, 45, 0.98) 100%);
        border: 1px solid;
        border-image: linear-gradient(135deg, 
          rgba(137, 180, 250, 0.4) 0%,
          rgba(203, 166, 247, 0.3) 50%,
          rgba(137, 180, 250, 0.4) 100%) 1;
        border-radius: 20px;
        margin: 0;
        box-shadow: 
          0 0 0 1px rgba(255, 255, 255, 0.05),
          0 8px 32px rgba(0, 0, 0, 0.4),
          0 4px 16px rgba(137, 180, 250, 0.1);
      }

      /* Header con efecto neón */
      .widget-title {
        background: linear-gradient(135deg,
          rgba(137, 180, 250, 0.15) 0%,
          rgba(203, 166, 247, 0.1) 100%);
        border-bottom: 1px solid rgba(137, 180, 250, 0.2);
        border-radius: 20px 20px 0 0;
        padding: 16px 20px;
        margin: 0;
      }

      .widget-title label {
        color: rgba(245, 224, 220, 0.95);
        font-weight: 700;
        font-size: 16px;
        text-shadow: 0 0 10px rgba(137, 180, 250, 0.3);
      }

      .widget-title button {
        background: linear-gradient(135deg, 
          rgba(137, 180, 250, 0.9) 0%,
          rgba(116, 199, 236, 0.9) 100%);
        border: none;
        border-radius: 10px;
        color: rgba(25, 25, 45, 0.95);
        font-weight: 700;
        padding: 8px 16px;
        margin: 0;
        box-shadow: 0 2px 8px rgba(137, 180, 250, 0.3);
      }

      /* Notificaciones tipo "cristal líquido" */
      .notification-row {
        background: transparent;
        outline: none;
      }

      .notification {
        background: linear-gradient(135deg,
          rgba(50, 50, 70, 0.7) 0%,
          rgba(40, 40, 60, 0.8) 100%);
        border: 1px solid;
        border-image: linear-gradient(135deg,
          rgba(137, 180, 250, 0.3) 0%,
          rgba(203, 166, 247, 0.2) 50%,
          rgba(137, 180, 250, 0.3) 100%) 1;
        border-radius: 16px;
        margin: 6px 10px;
        padding: 0;
        box-shadow: 
          0 4px 16px rgba(0, 0, 0, 0.3),
          0 2px 8px rgba(137, 180, 250, 0.1);
      }

      .notification-content {
        background: transparent;
        padding: 16px;
        border-radius: 16px;
      }

      .notification-default-action {
        background: transparent;
        border: none;
        border-radius: 16px;
        margin: 0;
        padding: 0;
      }

      /* Header de notificación con iconos */
      .notification-header {
        margin-bottom: 8px;
      }

      .notification-header label {
        color: rgba(245, 224, 220, 0.95);
        font-weight: 600;
        font-size: 14px;
      }

      .notification-header .time {
        color: rgba(166, 173, 200, 0.8);
        font-size: 11px;
        font-weight: 400;
      }

      /* Body con mejor legibilidad */
      .notification-body {
        color: rgba(205, 214, 244, 0.9);
        margin: 8px 0;
      }

      /* Imágenes con marco elegante */
      .image {
        border-radius: 12px;
        margin-right: 12px;
        border: 2px solid rgba(137, 180, 250, 0.3);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
      }

      /* Botones de acciones flotantes */
      .notification-actions {
        background: linear-gradient(135deg,
          rgba(30, 30, 50, 0.8) 0%,
          rgba(25, 25, 45, 0.9) 100%);
        border-radius: 0 0 16px 16px;
        margin: 0;
        padding: 10px;
        border-top: 1px solid rgba(137, 180, 250, 0.2);
      }

      .notification-actions button {
        background: linear-gradient(135deg,
          rgba(88, 91, 112, 0.6) 0%,
          rgba(70, 73, 92, 0.7) 100%);
        border: 1px solid rgba(137, 180, 250, 0.2);
        border-radius: 8px;
        color: rgba(205, 214, 244, 0.95);
        margin: 2px;
        padding: 6px 12px;
        font-weight: 500;
      }

      .notification-actions button:hover {
        background: linear-gradient(135deg,
          rgba(137, 180, 250, 0.3) 0%,
          rgba(116, 199, 236, 0.3) 100%);
        border-color: rgba(137, 180, 250, 0.4);
      }

      /* Widget MPRIS - Reproductor de música premium */
      .widget-mpris {
        background: linear-gradient(135deg,
          rgba(137, 180, 250, 0.1) 0%,
          rgba(203, 166, 247, 0.08) 100%);
        border: 1px solid rgba(137, 180, 250, 0.2);
        border-radius: 16px;
        margin: 8px;
        padding: 16px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
      }

      .mpris-title {
        color: rgba(245, 224, 220, 0.95);
        font-weight: 600;
        font-size: 14px;
      }

      .mpris-artist {
        color: rgba(166, 173, 200, 0.8);
        font-size: 12px;
        font-weight: 400;
      }

      /* Widgets de control con diseño cohesivo */
      .widget-volume, .widget-dnd, .widget-inhibitors {
        background: linear-gradient(135deg,
          rgba(50, 50, 70, 0.7) 0%,
          rgba(40, 40, 60, 0.8) 100%);
        border: 1px solid rgba(137, 180, 250, 0.2);
        border-radius: 14px;
        margin: 6px;
        padding: 12px 16px;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.2);
      }

      /* Barras de progreso modernas */
      scale trough {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 8px;
        min-height: 6px;
        border: 1px solid rgba(255, 255, 255, 0.05);
      }

      scale highlight {
        background: linear-gradient(90deg,
          rgba(137, 180, 250, 0.9) 0%,
          rgba(116, 199, 236, 0.9) 50%,
          rgba(203, 166, 247, 0.9) 100%);
        border-radius: 8px;
        box-shadow: 0 0 4px rgba(137, 180, 250, 0.4);
      }

      /* Estados de urgencia con colores vibrantes */
      .notification.urgency-critical {
        border-left: 4px solid;
        border-image: linear-gradient(180deg,
          rgba(243, 139, 168, 0.9) 0%,
          rgba(235, 160, 172, 0.8) 100%) 1;
        background: linear-gradient(90deg,
          rgba(243, 139, 168, 0.1) 0%,
          transparent 30%);
      }

      .notification.urgency-normal {
        border-left: 4px solid;
        border-image: linear-gradient(180deg,
          rgba(249, 226, 175, 0.9) 0%,
          rgba(245, 224, 220, 0.8) 100%) 1;
      }

      .notification.urgency-low {
        border-left: 4px solid;
        border-image: linear-gradient(180deg,
          rgba(166, 227, 161, 0.9) 0%,
          rgba(166, 218, 149, 0.8) 100%) 1;
      }

      /* Switch DND moderno */
      .widget-dnd switch {
        background: rgba(70, 73, 92, 0.8);
        border-radius: 12px;
        min-width: 44px;
        min-height: 24px;
        border: 1px solid rgba(137, 180, 250, 0.2);
      }

      .widget-dnd switch:checked {
        background: linear-gradient(135deg,
          rgba(137, 180, 250, 0.9) 0%,
          rgba(116, 199, 236, 0.9) 100%);
      }

      .widget-dnd switch slider {
        background: rgba(245, 224, 220, 0.95);
        border-radius: 50%;
        min-width: 20px;
        min-height: 20px;
        margin: 2px;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3);
      }

      /* Scrollbar invisible pero funcional */
      scrollbar {
        background: transparent;
      }

      scrollbar trough {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 4px;
        min-width: 6px;
      }

      scrollbar slider {
        background: rgba(137, 180, 250, 0.4);
        border-radius: 4px;
        min-width: 8px;
      }

      /* Estado vacío elegante */
      .empty-notifications {
        color: rgba(166, 173, 200, 0.6);
        font-style: italic;
        padding: 40px 20px;
        text-align: center;
        font-size: 14px;
      }
    '';
  };
}
