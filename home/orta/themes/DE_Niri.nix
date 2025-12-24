{ config, pkgs, lib, inputs, ... }:

{
  # Generar el archivo de configuración de Niri para este usuario específico
  home.file.".config/niri/config.kdl".text = ''
    //======================== Teclado y touchpad =========================

    input {
      keyboard {
        xkb {
          layout "latam"
        }
        track-layout "global"
      }

      touchpad {
        accel-speed 0.8
        scroll-factor 1.5
        tap
        natural-scroll
      }
    }
    

    //======================== Pantalla y decoraciones =========================
    output "eDP-1" {
      mode "1920x1080@60"
      scale 1
      transform "normal"
      position x=0 y=0
    }

    // Decoraciones
    layout {
      gaps 15
      center-focused-column "never"
            
      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        proportion 0.8
        proportion 1.0
      }
      
      default-column-width { proportion 0.5; }
      
      focus-ring {
        off
      }
      
      border {
        off
        width 4
        active-gradient from="#700BBA" to="#7fc8ff" angle=45
        inactive-color "transparent"    
      }
      
      shadow {
        on
        softness 30
        spread 5
        offset x=0 y=5
        color "#0007"
      }  

      background-color "transparent"
    }
    

    //======================== Miscelaneos =========================
    spawn-at-startup "/etc/nixos/modules/scripts/LiveWallpaper"
    spawn-at-startup "swaync"
    spawn-at-startup "xwayland-satellite"

    prefer-no-csd
    
    layer-rule {
      match namespace="^mpvpaper$"
      place-within-backdrop true
    }
    
    hotkey-overlay {
      skip-at-startup
    }

    overview {
      zoom 0.5
      workspace-shadow {
        off
      }
    }
    
    gestures {
      dnd-edge-view-scroll {
          trigger-width 30
          delay-ms 300
          max-speed 1500
      }

      dnd-edge-workspace-switch {
          trigger-height 50
          delay-ms 400
          max-speed 1500
      }
          
      hot-corners {
        off
      }
    }
    
    clipboard {
      disable-primary
    }

    cursor {
      hide-after-inactive-ms 1000
      hide-when-typing
    }
    
    switch-events {
        lid-close { spawn "notify-send" "The laptop lid is closed!"; }
        lid-open { spawn "notify-send" "The laptop lid is open!"; }
        tablet-mode-on { spawn "bash" "-c" "gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true"; }
        tablet-mode-off { spawn "bash" "-c" "gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false"; }
    }

    recent-windows {
      off
      debounce-ms 750

      open-delay-ms 150

      highlight {
          active-color "#999999ff"
          urgent-color "#ff9999ff"
          padding 30
          corner-radius 0
      }

      previews {
          max-height 480
          max-scale 0.5
      }

      binds {
          Alt+Tab         { next-window; }
          Alt+Shift+Tab   { previous-window; }
          Alt+grave       { next-window     filter="app-id"; }
          Alt+Shift+grave { previous-window filter="app-id"; }

          Mod+Tab         { next-window; }
          Mod+Shift+Tab   { previous-window; }
          Mod+grave       { next-window     filter="app-id"; }
          Mod+Shift+grave { previous-window filter="app-id"; }
      }
    }   
    screenshot-path "~/Imágenes/Niri - Realizada el %Y-%m-%d %H-%M-%S.png"

    //======================== Animaciones =========================

    animations {
        slowdown 1.75
        
        workspace-switch {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }
        
        window-open {
            duration-ms 150
            curve "ease-out-expo"
        }
        
        window-close {
          duration-ms 150
          curve "ease-out-quad"
        }
        
        horizontal-view-movement {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }

        window-movement {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }

        window-resize {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }

        config-notification-open-close {
            spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
        }

        exit-confirmation-open-close {
            spring damping-ratio=0.6 stiffness=500 epsilon=0.01
        }

        screenshot-ui-open {
            duration-ms 200
            curve "ease-out-quad"
        }

        overview-open-close {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }

        recent-windows-close {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.001
        }
    }
   
     //======================== Especificaciones de ventanas =========================

    window-rule {
      match app-id="ghostty"
      open-on-output "left"
      open-floating true
      default-floating-position x=0 y=40 relative-to="bottom"
      default-window-height { proportion 0.3; }
      default-column-width { proportion 0.9; }
      border {
          on
          width 2
      }
    }

    window-rule {
      match app-id="zen-beta" title="^Picture-in-Picture$"
      open-floating true
    }
    
    window-rule{
      match app-id="zen-beta"
      default-column-width { proportion 1.0; }
    }
    
    window-rule{
      match app-id="org.gnome.Nautilus"
      default-column-width { proportion 0.33333; }
    }
    
    window-rule{
      match app-id="dev.zed.Zed"
      default-column-width { proportion 0.66667; }
    }
    
    window-rule{
      match app-id="google-chrome"
      default-column-width { proportion 1.0; }
    }
    
    window-rule {
      match app-id="Bitwarden"
      open-on-output "left"
      default-column-width { proportion 0.33333; }
      block-out-from "screen-capture"
    }
    
    window-rule {
      geometry-corner-radius 12.0
      clip-to-geometry true
      opacity 0.99
    }
    
    window-rule {
      match is-focused=false
      opacity 0.95
    }

    window-rule {
      match is-floating=true
      border {
          on
      }
    }

    binds {
      Mod+Shift+Apostrophe { show-hotkey-overlay; }
      
        //Atajos para aplicaciones
      Mod+T { spawn "ghostty"; }
      Mod+W { spawn "zen"; }
      Mod+C { spawn "code"; }
      Mod+F { spawn "nautilus"; }
      Mod+Space { spawn "fuzzel"; }
      Mod+P { spawn "powermenu"; }
      Mod+B { spawn "bgselector"; }
      Mod+Alt+L { spawn "swaylock"; }
      Mod+Alt+S allow-when-locked=true { spawn "sh" "-c" "pkill orca || exec orca"; }
      Mod+Alt+R { spawn-sh "wf-recorder -g \"$(slurp)\" --audio -f ~/Vídeos/Niri - $(date +%s).mp4";}
      
        // Correcta configuracion de los atajos de la laptop
      XF86AudioRaiseVolume allow-when-locked=true { spawn "sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }
      XF86AudioLowerVolume allow-when-locked=true { spawn "sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
      XF86AudioMute allow-when-locked=true { spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
      XF86AudioMicMute allow-when-locked=true { spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

      XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
      XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

      Mod+tab repeat=false { toggle-overview; }
            
      Mod+Q { close-window; }

      Mod+Left { focus-column-left; }
      Mod+Down { focus-window-down; }
      Mod+Up { focus-window-up; }
      Mod+Right { focus-column-right; }
      Mod+H { focus-column-left; }
      Mod+J { focus-window-down; }
      Mod+K { focus-window-up; }
      Mod+L { focus-column-right; }

      Mod+Ctrl+Left { move-column-left; }
      Mod+Ctrl+Page_Down{ move-window-down; }
      Mod+Ctrl+Page_Up { move-window-up; }
      Mod+Ctrl+Right { move-column-right; }
      Mod+Ctrl+H { move-column-left; }
      Mod+Ctrl+J { move-window-down; }
      Mod+Ctrl+K { move-window-up; }
      Mod+Ctrl+L { move-column-right; }

      Mod+Home { focus-column-first; }
      Mod+End { focus-column-last; }
      Mod+Ctrl+Home { move-column-to-first; }
      Mod+Ctrl+End { move-column-to-last; }

      Mod+Shift+Left { focus-monitor-left; }
      Mod+Shift+Down { focus-monitor-down; }
      Mod+Shift+Up { focus-monitor-up; }
      Mod+Shift+Right { focus-monitor-right; }
      Mod+Shift+H { focus-monitor-left; }
      Mod+Shift+J { focus-monitor-down; }
      Mod+Shift+K { focus-monitor-up; }
      Mod+Shift+L { focus-monitor-right; }

      Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+L { move-column-to-monitor-right; }

      Mod+Page_Down { focus-workspace-down; }
      Mod+Page_Up { focus-workspace-up; }
      Mod+U { focus-workspace-down; }
      Mod+I { focus-workspace-up; }
      Mod+Ctrl+Down { move-column-to-workspace-down; }
      Mod+Ctrl+Up { move-column-to-workspace-up; }
      Mod+Ctrl+U { move-column-to-workspace-down; }
      Mod+Ctrl+I { move-column-to-workspace-up; }

      Mod+Shift+Page_Down { move-workspace-down; }
      Mod+Shift+Page_Up { move-workspace-up; }
      Mod+Shift+U { move-workspace-down; }
      Mod+Shift+I { move-workspace-up; }

      Mod+WheelScrollDown { focus-workspace-down; }
      Mod+WheelScrollUp { focus-workspace-up; }
      Mod+Ctrl+WheelScrollDown { move-column-to-workspace-down; }
      Mod+Ctrl+WheelScrollUp { move-column-to-workspace-up; }

      Mod+WheelScrollRight { focus-column-right; }
      Mod+WheelScrollLeft { focus-column-left; }
      Mod+Ctrl+WheelScrollRight { move-column-right; }
      Mod+Ctrl+WheelScrollLeft { move-column-left; }

      Mod+Shift+WheelScrollDown { focus-column-right; }
      Mod+Shift+WheelScrollUp { focus-column-left; }
      Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
      Mod+Ctrl+Shift+WheelScrollUp { move-column-left; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      
      Mod+Ctrl+1 { move-column-to-workspace 1; }
      Mod+Ctrl+2 { move-column-to-workspace 2; }
      Mod+Ctrl+3 { move-column-to-workspace 3; }
      Mod+Ctrl+4 { move-column-to-workspace 4; }
      Mod+Ctrl+5 { move-column-to-workspace 5; }
      Mod+Ctrl+6 { move-column-to-workspace 6; }
      Mod+Ctrl+7 { move-column-to-workspace 7; }
      Mod+Ctrl+8 { move-column-to-workspace 8; }
      Mod+Ctrl+9 { move-column-to-workspace 9; }

      Mod+BracketLeft { consume-or-expel-window-left; }
      Mod+BracketRight { consume-or-expel-window-right; }
      Mod+Comma { consume-window-into-column; }
      Mod+Period { expel-window-from-column; }

      Mod+R { switch-preset-column-width; }
      Mod+Shift+R { switch-preset-window-height; }
      Mod+Ctrl+R { reset-window-height; }
      Mod+M { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+Ctrl+F { expand-column-to-available-width; }

      Mod+ctrl+alt+C { center-column; }
      Mod+Ctrl+C { center-visible-columns; }

      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }
      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }

      Mod+V { toggle-window-floating; }
      Mod+Shift+V { switch-focus-between-floating-and-tiling; }

      Mod+Ctrl+W { toggle-column-tabbed-display; }

      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }

      Mod+Escape { toggle-keyboard-shortcuts-inhibit; }
      Mod+Shift+E { quit; }
      Ctrl+Alt+Delete { quit; }
      Mod+Shift+P { power-off-monitors; }
    }
  '';
}
