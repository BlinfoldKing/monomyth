update:
	@just os
	@just home

home:
	home-manager build switch --flake .#blinfoldking@nixos

os:
	sudo nixos-rebuild switch --flake .
  
open-eww:
	eww open --config ./home-manager/hyprland/widgets header
	eww open --config ./home-manager/hyprland/widgets workspace
	eww open --config ./home-manager/hyprland/widgets power-button
	eww open --config ./home-manager/hyprland/widgets tray

close-eww:
	eww close-all --config ./home-manager/hyprland/widgets


