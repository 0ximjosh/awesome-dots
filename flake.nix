{
  description = "Mira Config";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nixneovimplugins.url = "github:NixNeovim/NixNeovimPlugins";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      grub2-themes,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.mira = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        # ... and then to your modules
        modules = [
          grub2-themes.nixosModules.default
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./nvim.nix
        ];
      };
    };
}
