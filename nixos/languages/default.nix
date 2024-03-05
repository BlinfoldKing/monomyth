{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    gcc

    rustup

    go
    gotools
    gopls
    go-outline
    gopkgs
    gocode-gomod
    godef
    golint

    nodejs
    yarn

    swiProlog

    ruby

    stack

    zig
  ];
}
