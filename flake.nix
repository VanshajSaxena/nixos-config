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
    hyprland.url = "github:hyprwm/Hyprland";
    catppuccin.url = "github:catppuccin/nix";
    # temporary flake for zen-browser
    zen-browser-flake.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      zen-browser-flake,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      enabledHyprland = true;
    in
    {
      nixosConfigurations.NIXOS = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs enabledHyprland;
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
        ];
      };

      homeConfigurations = {
        "vanshaj" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            ./home-manager/home.nix
            catppuccin.homeModules.catppuccin
          ];
          extraSpecialArgs = {
            zen-browser = zen-browser-flake;
            inherit inputs enabledHyprland;
          };
        };
      };
    };
}
