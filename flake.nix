{
  description = "NixOS configuration";

  inputs = {
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, nixos-unstable, ... }@inputs: {
    nixosConfigurations = {
      VSENVY = nixos-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}

