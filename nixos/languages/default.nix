{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    rustup

    go
    gotools
    gopls
    go-outline
    gopkgs
    gocode-gomod
    godef
    golint
    mockgen

    gcc

    nodejs
    yarn
  ];

}
