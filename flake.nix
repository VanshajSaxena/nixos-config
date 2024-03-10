{
  description = "NixOS configuration";

  inputs = {
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixos-unstable, ... }@inputs: {
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

