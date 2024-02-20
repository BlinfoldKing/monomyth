{ ... }: {
  virtualisation.docker.enable = true;
  users.users.blinfoldking.extraGroups = [ "docker" ];
}
