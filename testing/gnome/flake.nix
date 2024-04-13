{
  inputs = {
    # NixOS official package source, here using the nixos-unstable branch and home-manager
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
    url = "github:nix-community/home-manager/master";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    #lanzaboote.url = "github:nix-community/lanzaboote/v0.3.0";
  };

 nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.user = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
      ./nixconf
         home-manager.nixosModules.home-manager
         {
         home-manager.useGlobalPkgs = false;
         home-manager.useUserPackages = true;
         home-manager.users.user = import ./home.nix;
         }
      ];
    };
  };
}
