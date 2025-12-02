{ config, pkgs, ... }:

{
  # PipeWire (reemplaza PulseAudio y JACK)
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

  # Paquetes útiles de audio
  environment.systemPackages = with pkgs; [
    pavucontrol  # Control gráfico de volumen
    #easyeffects  # Efectos de audio
    #helvum       # Patchbay para PipeWire
  ];
}