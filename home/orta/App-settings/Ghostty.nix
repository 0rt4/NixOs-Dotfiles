{ pkgs, ... }:

{
 programs.ghostty = {
   enable=true;
   settings = {
     theme = "Cyberpunk Scarlet Protocol";

     font-family = "JetBrainsMono Nerd Font";
     font-size = 12;

     background-opacity = 0.70;
   };
 };
}
