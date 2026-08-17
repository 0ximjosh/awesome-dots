{
  description = "Mira Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim = {
      url = "path:./nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      grub2-themes,
      home-manager,
      nvim,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      overlay = final: prev: {
        cursor = final.callPackage ./pkgs/cursor { };
      };
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            overlay
            nvim.overlays.default
          ];
        };
    in
    {
      overlays.default = nixpkgs.lib.composeManyExtensions [
        overlay
        nvim.overlays.default
      ];

      packages = forAllSystems (system: {
        cursor = (pkgsFor system).cursor;
        nvim = nvim.packages.${system}.default;
      });

      apps = forAllSystems (system: {
        cursor = {
          type = "app";
          program = "${self.packages.${system}.cursor}/bin/cursor";
        };
        nvim = {
          type = "app";
          program = "${self.packages.${system}.nvim}/bin/nvim";
        };
      });

      nixosConfigurations.mira = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ overlay ]; }
          grub2-themes.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/mira
        ];
      };
    };
}
