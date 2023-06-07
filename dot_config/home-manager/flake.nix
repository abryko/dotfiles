{
  description = "Home Manager configuration of xmaillard";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixGL,
    ...
  }: let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    nixgl = nixGL.packages.${system};
  in {
    homeConfigurations."xmaillard" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home.nix];

      extraSpecialArgs = {
        inherit nixgl;
      };
      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
