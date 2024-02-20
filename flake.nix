{
  description = "A NixOS config with thousands stories";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/Hyprland";

    utils.url = "github:numtide/flake-utils";

  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , utils
    , systems
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
    in
    utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages = {
        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs outputs; };
            modules = [
              ./nixos/core.nix
            ];
          };
        };

        homeConfigurations = {
          "blinfoldking@nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs outputs; };
            modules = [ ./home-manager/home.nix ];
          };
        };
      };


      devShells.default =
        let
          repo = "github:blinfoldking/monomyth";
          scripts = with pkgs; [
            (writeScriptBin "helpme" ''
              _usage="
              make sure you check and adjust everything, then run
              one of these commands

              COMMAND       USAGE
              install       to install/update the whole config
              update-os     to update os config
              update-home   to update home manager
              logout        logout user
              reboot        restart your system

              PS: this shell include vim for you to make
              simple edits
              "

              echo "$_usage"
            '')

            (writeScriptBin "install" ''
              echo "install source: "$MODE
              update-os && update-home
            '')

            (writeScriptBin "update-os" ''
              if [[ "$MODE" == "github" ]];
              then
                sudo nixos-rebuild switch --impure --flake ${repo}
              else
                sudo nixos-rebuild switch --impure --flake .
              fi
            '')

            (writeScriptBin "update-home" ''
              if [[ "$MODE" == "github" ]];
              then
                home-manager build switch --flake ${repo}#blinfoldking@nixos
              else
                home-manager build switch --flake .#blinfoldking@nixos
              fi
            '')

            (writeScriptBin "logout" ''
              pkill -KILL -u $USER
            '')
          ];
        in
        pkgs.mkShell {
          name = "monomyth-install";

          packages = with pkgs; [
            git
            vim
            just
          ] ++ scripts;

          shellHook = ''
            helpme
          '';

          MODE = "github";
        };

    });
}
