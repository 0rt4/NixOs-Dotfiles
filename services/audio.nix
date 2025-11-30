{ config, pkgs, lib, ... }:

{
  # PipeWire (reemplazo moderno de PulseAudio)
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Configuración de baja latencia (opcional)
    # extraConfig.pipewire."92-low-latency" = {
    #   context.properties = {
    #     default.clock.rate = 48000;
    #     default.clock.quantum = 32;
    #     default.clock.min-quantum = 32;
    #     default.clock.max-quantum = 32;
    #   };
    # };
  };

  # Paquetes de audio
  environment.systemPackages = with pkgs; [
    pavucontrol
   #playerctl
   #pamixer
   #pulsemixer
    # easyeffects  # Efectos de audio avanzados
  ];
}
