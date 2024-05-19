{
  description = "My first NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    xremap-flake.url = "github:xremap/nix-flake";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, xremap-flake, ... }: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.VSENVY = nixpkgs.lib.nixosSystem rec {
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
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        xremap-flake.nixosModules.default
        {
          services.xremap.config.modmap = [{
            name = "Global";
            remap = { "CapsLock" = "Esc"; };
            remap = { "RightAlt" = "RightCtrl"; };
          }];
        }

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # TODO replace ryan with your own username
          home-manager.users.vanshaj = import ./home.nix;

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
