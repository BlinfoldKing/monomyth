{ pkgs, palette, ... }:
let
  config = with palette; pkgs.writeText "config" ''
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 5
    font = "Caskaydia Cove Nerd Font"
    background-color = #${base00}AA
    selection-color = #${base08}
  '';
in
"tofi-drun -c ${config} | xargs hyprctl dispatch exec" 
