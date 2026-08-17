{
  description = "Standalone Neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixneovimplugins.url = "github:NixNeovim/NixNeovimPlugins";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixneovimplugins,
    }:
    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = lib.genAttrs systems;
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ nixneovimplugins.overlays.default ];
          config.allowUnfree = true;
        };
    in
    {
      overlays.default = lib.composeManyExtensions [
        nixneovimplugins.overlays.default
        (
          final: _prev: {
            nvim-awesome = import ./package.nix {
              pkgs = final;
              inherit (final) lib;
            };
          }
        )
      ];

      homeManagerModules.default = import ./hm-module.nix { inherit nixneovimplugins; };

      packages = forAllSystems (
        system:
        let
          nvim = import ./package.nix {
            pkgs = pkgsFor system;
            inherit lib;
          };
        in
        {
          inherit nvim;
          default = nvim;
        }
      );

      apps = forAllSystems (
        system:
        let
          app = {
            type = "app";
            program = "${self.packages.${system}.nvim}/bin/nvim";
          };
        in
        {
          default = app;
          nvim = app;
        }
      );
    };
}
