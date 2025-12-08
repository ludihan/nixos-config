{
  description = "ludihan nix config :^)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    templates.url = "github:nixos/templates";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    todo = {
      url = "github:ludihan/todo";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-index-database, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    hmBase = hostPath:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          hostPath
          nix-index-database.homeModules.nix-index
          { programs.nix-index-database.comma.enable = true; }
        ];
      };
  in
  {
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/desktop ];
      };

      nixos-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/laptop ];
      };
    };

    homeConfigurations = {
      "ludihan@nixos-desktop" = hmBase ./hosts/desktop/home.nix;
      "ludihan@nixos-laptop"  = hmBase ./hosts/laptop/home.nix;
    };

    templates = inputs.templates;

    packages.${system} = import ./pkgs { inherit inputs pkgs; };
  };
}
