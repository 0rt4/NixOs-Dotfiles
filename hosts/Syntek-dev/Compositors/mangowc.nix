{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  # 1. Habilitamos el binario
  programs.mango.enable = true;

  # 2. Creamos el archivo de configuración en /etc de forma declarativa
  environment.etc."mango/config.conf".text = ''
    #Startups
    exec-once = dms run
    exec-once=wl-paste --type text --watch cliphist store
    exec = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango

    #enviroment
    env=QT_QPA_PLATFORM,wayland
    env=ELECTRON_OZONE_PLATFORM_HINT,auto
    env=QT_QPA_PLATFORMTHEME,gtk3

    # Window effect
    blur=0
    blur_layer=15
    blur_optimized=1
    blur_params_num_passes = 2
    blur_params_radius = 5
    blur_params_noise = 0.02
    blur_params_brightness = 0.9
    blur_params_contrast = 0.9
    blur_params_saturation = 1.2

    shadows = 1
    layer_shadows = 0
    shadow_only_floating = 1
    shadows_size = 10
    shadows_blur = 15
    shadows_position_x = 0
    shadows_position_y = 0
    shadowscolor= 0x000000ff

    border_radius=12
    no_radius_when_single=0
    focused_opacity=0.95
    unfocused_opacity=0.9

    # Animation Configuration
    animations=1
    layer_animations=1
    animation_type_open=zoom
    animation_type_close=zoom
    animation_fade_in=1
    animation_fade_out=1
    tag_animation_direction=1
    zoom_initial_ratio=0.3
    zoom_end_ratio=0.8
    fadein_begin_opacity=0.5
    fadeout_begin_opacity=0.8
    animation_duration_move=600
    animation_duration_open=500
    animation_duration_tag=550
    animation_duration_close=1000
    animation_duration_focus=0
    animation_curve_open=0.46,1.0,0.29,1
    animation_curve_move=0.46,1.0,0.29,1
    animation_curve_tag=0.46,1.0,0.29,1
    animation_curve_close=0.08,0.92,0,1
    animation_curve_focus=0.46,1.0,0.29,1
    animation_curve_opafadeout=0.5,0.5,0.5,0.5
    animation_curve_opafadein=0.46,1.0,0.29,1

    # Scrollabe Layout Setting
    scroller_structs=20
    scroller_default_proportion=0.5
    scroller_focus_center=0
    scroller_prefer_center=0
    edge_scroller_pointer_focus=1
    scroller_default_proportion_single=1.0
    scroller_proportion_preset=0.33333,0.5,0.66667,1.0

    # Master-Stack Layout Setting
    new_is_master=1
    default_mfact=0.55
    default_nmaster=1
    smartgaps=0

    # Overview Setting
    enable_hotarea=0
    hotarea_size=10
    ov_tab_mode=1
    overviewgappi=15
    overviewgappo=100

    # Misc
    monitorruler = eDP-1,0.55,1,title,0,1,0,0,1920,1080,60
    no_border_when_single=0
    axis_bind_apply_timeout=100
    focus_on_activate=1
    idleinhibit_ignore_visible=0
    sloppyfocus=1
    warpcursor=1
    focus_cross_monitor=0
    focus_cross_tag=0
    enable_floating_snap=0
    snap_distance=30
    cursor_size=24
    drag_tile_to_tile=1

    # keyboard
    repeat_rate=25
    repeat_delay=600
    numlockon=1
    xkb_rules_layout=latam

    # Trackpad
    disable_trackpad=0
    tap_to_click=1
    tap_and_drag=1
    drag_lock=1
    trackpad_natural_scrolling=1
    disable_while_typing=1
    left_handed=0
    middle_button_emulation=0
    swipe_min_threshold=1

    # mouse
    mouse_natural_scrolling=0

    # Appearance
    gappih=5
    gappiv=5
    gappoh=5
    gappov=5
    scratchpad_width_ratio=0.8
    scratchpad_height_ratio=0.9
    borderpx=0
    rootcolor=0x201b14ff
    bordercolor=0x444444ff
    focuscolor=0xc9b890ff
    maximizescreencolor=0x89aa61ff
    urgentcolor=0xad401fff
    scratchpadcolor=0x516c93ff
    globalcolor=0xb153a7ff
    overlaycolor=0x14a57cff

    # layout support
    tagrule=id:1,layout_name:tile
    tagrule=id:2,layout_name:tile
    tagrule=id:3,layout_name:tile
    tagrule=id:4,layout_name:tile
    tagrule=id:5,layout_name:tile
    tagrule=id:6,layout_name:tile
    tagrule=id:7,layout_name:tile
    tagrule=id:8,layout_name:tile
    tagrule=id:9,layout_name:tile

    # Key Bindings
    bind=SUPER,r,reload_config
    bind=SUPER,space,spawn,dms ipc call spotlight toggle
    bind=SUPER,v,spawn,dms ipc call clipboard toggle
    bind=SUPER,m,spawn,dms ipc call processlist focusOrToggle
    bind=SUPER,comma,spawn,dms ipc call settings focusOrToggle
    bind=SUPER,n,spawn,dms ipc call notifications toggle
    bind=SUPER,y,spawn,dms ipc call dankdash wallpaper
    bind=NONE,Print, spawn, /etc/nixos/modules/scripts/screenshot
    bind=SUPER,Return,spawn,ghostty
    bind=SUPER,f,spawn,nautilus
    bind=SUPER,w,spawn,zen

    # scripts
    bind=SUPER,p,spawn,/home/orta/Documentos/autoclick.sh
    
    # Security
    bind=SUPER+ALT,l,spawn,dms ipc call lock lock

    # Audio
    bind=NONE,XF86AudioRaiseVolume,spawn,dms ipc call audio increment 3
    bind=NONE,XF86AudioLowerVolume,spawn,dms ipc call audio decrement 3
    bind=NONE,XF86AudioMute,spawn,dms ipc call audio mute

    # Brightness
    bind=NONE,XF86MonBrightnessUp,spawn,dms ipc call brightness increment 5 ""
    bind=NONE,XF86MonBrightnessDown,spawn,dms ipc call brightness decrement 5 ""

    # exit
    bind=SUPER,m,quit
    bind=SUPER,q,killclient,

    # switch window focus
    bind=ALT,Tab,focusstack,next
    bind=SUPER,Left,focusdir,left
    bind=SUPER,Right,focusdir,right
    bind=SUPER,Up,focusdir,up
    bind=SUPER,Down,focusdir,down

    # swap window
    bind=SUPER+CTRL,Up,exchange_client,up
    bind=SUPER+CTRL,Down,exchange_client,down
    bind=SUPER+CTRL,Left,exchange_client,left
    bind=SUPER+CTRL,Right,exchange_client,right

    # switch window status
    bind=SUPER,g,toggleglobal,
    bind=ALT,Tab,toggleoverview,
    bind=SUPER+CTRL,period,togglefloating,
    bind=ALT,a,togglemaximizescreen,
    bind=ALT,f,togglefullscreen,
    bind=ALT+SHIFT,f,togglefakefullscreen,
    bind=ALT,i,minimized,
    bind=ALT,o,toggleoverlay,
    bind=ALT+SHIFT,I,restore_minimized
    bind=ALT,z,toggle_scratchpad

    # scroller layout
    bind=ALT,e,set_proportion,5.0
    bind=ALT,x,switch_proportion_preset,

    # switch layout
    bind=SUPER,t,switch_layout

    # tag switch
    bind=SUPER+Shift,Left,viewtoleft,0
    bind=CTRL,Left,viewtoleft_have_client,0
    bind=SUPER+Shift,Right,viewtoright,0
    bind=CTRL,Right,viewtoright_have_client,0
    bind=SUPER+ALT,Left,tagtoleft,0
    bind=SUPER+ALT,Right,tagtoright,0

    bind=SUPER,1,view,1,0
    bind=SUPER,2,view,2,0
    bind=SUPER,3,view,3,0
    bind=SUPER,4,view,4,0
    bind=SUPER,5,view,5,0
    bind=SUPER,6,view,6,0
    bind=SUPER,7,view,7,0
    bind=SUPER,8,view,8,0
    bind=SUPER,9,view,9,0

    # tag move
    bind=SUPER+ALT,1,tag,1,0
    bind=SUPER+ALT,2,tag,2,0
    bind=SUPER+ALT,3,tag,3,0
    bind=SUPER+ALT,4,tag,4,0
    bind=SUPER+ALT,5,tag,5,0
    bind=SUPER+ALT,6,tag,6,0
    bind=SUPER+ALT,7,tag,7,0
    bind=SUPER+ALT,8,tag,8,0
    bind=SUPER+ALT,9,tag,9,0

    # gaps
    bind=ALT+SHIFT,X,incgaps,1
    bind=ALT+SHIFT,Z,incgaps,-1
    bind=ALT+SHIFT,R,togglegaps

    # movewin
    bind=CTRL+SHIFT,Up,movewin,+0,-50
    bind=CTRL+SHIFT,Down,movewin,+0,+50
    bind=CTRL+SHIFT,Left,movewin,-50,+0
    bind=CTRL+SHIFT,Right,movewin,+50,+0

    # resizewin
    bind=CTRL+ALT,Up,resizewin,+0,-50
    bind=CTRL+ALT,Down,resizewin,+0,+50
    bind=CTRL+ALT,Left,resizewin,-50,+0
    bind=CTRL+ALT,Right,resizewin,+50,+0

    # Mouse
    mousebind=SUPER,btn_left,moveresize,curmove
    mousebind=NONE,btn_middle,togglemaximizescreen,0
    mousebind=SUPER,btn_right,moveresize,curresize
    mousebind=NONE,btn_left,toggleoverview,1
    mousebind=NONE,btn_right,killclient,0

    # Gestures
    gesturebind=none,up,4,toggleoverview

    # Axis
    axisbind=SUPER,UP,viewtoleft_have_client
    axisbind=SUPER,DOWN,viewtoright_have_client

    # Rules
    layerrule=animation_type_open:zoom,layer_name:rofi
    layerrule=animation_type_close:zoom,layer_name:rofi
    layerrule=noanim:1,layer_name:^dms

    windowrule=isnoborder:1,appid:^org\.gnome\.
    windowrule=isfloating:1,width:1800,height:300,offsety:-90,appid:ghostty
    windowrule=isnoborder:1,appid:^org\.wezfurlong\.wezterm$
    windowrule=isnoborder:1,appid:^Alacritty$
    windowrule=isnoborder:1,appid:^com\.mitchellh\.ghostty$
    windowrule=isnoborder:1,appid:^kitty$
    windowrule=isfloating:1,appid:^org\.quickshell$
  '';

  # 3. Forzamos el enlace para que Mango lo lea desde la ruta de usuario
  # Esto evita tener que usar Home Manager para esta tarea específica.
  system.userActivationScripts.linkMangoConfig = {
    text = ''
      mkdir -p $HOME/.config/mango
      ln -sfn /etc/mango/config.conf $HOME/.config/mango/config.conf
    '';
  };
}
