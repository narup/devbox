
{
  description = "Flake definition for the entier devbox setup";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
    };
  };

  
  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "aarch64-linux";
      dev_user = "puran";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nix = {
        package = pkgs.nixVersions.latest;
        extraOptions = ''
          experimental-features = nix-command flakes
          keep-outputs = true
          keep-derivations = true
        '';
      };

      homeConfigurations.${dev_user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
