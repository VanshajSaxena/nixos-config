{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    {
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.NIXOS = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          nixos-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          #nixos-unstable = import nixpkgs-unstable {
          #inherit system;
          #config.allowUnfree = true;
          #};
        };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vanshaj = import ./home.nix;
            home-manager.backupFileExtension = "backup";

            home-manager.extraSpecialArgs = {
              #pkgs-stable = import nixpkgs-stable {
              #inherit system;
              #config.allowUnfree = true;
              #};
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            };
          }
        ];
      };
    };
}
