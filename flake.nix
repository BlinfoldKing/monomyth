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
      repo = "github:blinfoldking/monomyth";
      username = builtins.getEnv "USER";

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
            specialArgs = { inherit inputs outputs username; };
            modules = [
              ./nixos/core.nix
            ];
          };
        };

        homeConfigurations = {
          "${username}@nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs outputs username; };
            modules = [ ./home-manager/home.nix ];
          };
        };
      };


      devShells.default =
        let
          build-os = "sudo nixos-rebuild switch --impure --flake";
          upgrade-os = "sudo nixos-rebuild --upgrade switch --impure --flake";
          build-home = "home-manager build switch --impure --flake";
          scripts = with pkgs; [
            (writeScriptBin "helpme" ''
              _usage="
              make sure you check and adjust everything, then run
              one of these commands

              COMMAND       USAGE
              install       to install/update the whole config
              update-os     to update os config
              upgrade-os    to upgrade os config
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
                ${build-os} ${repo}
              else
                ${build-os} .
              fi
            '')

            (writeScriptBin "update-home" ''
              if [[ "$MODE" == "github" ]];
              then
                ${build-home} ${repo}#$USER@nixos
              else
                ${build-home} .#$USER@nixos
              fi
            '')

            (writeScriptBin "logout" ''
              pkill -KILL -u $USER
            '')

            (writeScriptBin "upgrade-os" ''
              if [[ "$MODE" == "github" ]];
              then
                ${upgrade-os} ${repo}
              else
                ${upgrade-os} .
              fi
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
        };

    });
}
