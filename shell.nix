let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  packages = with pkgs; [
    git
    neovim
    just
  ];

  shellHook = ''
    source ${./.env}
  '';
}
