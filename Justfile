update:
	@just home
	@just os

home:
	home-manager build switch --flake .#blinfoldking@nixos

os:
	sudo nixos-rebuild switch --flake .
  

