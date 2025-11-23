{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # temporary flake for zen-browser
    zen-browser-flake.url = "github:0xc000022070/zen-browser-flake";
    niri-flake.url = "github:sodiboo/niri-flake";
  };

  outputs =
    {
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      zen-browser-flake,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.NIXOS = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
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
            home-manager.users.vanshaj = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              zen-browser = zen-browser-flake;
            };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}
