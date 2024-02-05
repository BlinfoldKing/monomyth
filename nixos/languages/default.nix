{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    rustup

    go
    gcc
  ];

}
