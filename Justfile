update:
	@just os
	@just home

home:
	home-manager build switch --flake .#blinfoldking@nixos

os:
	sudo nixos-rebuild switch --flake .
