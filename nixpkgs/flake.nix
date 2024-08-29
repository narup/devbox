
{
  description = "Flake definition for the entier devbox setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  
  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "aarch64-linux";
      dev_user = "puran";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${dev_user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
