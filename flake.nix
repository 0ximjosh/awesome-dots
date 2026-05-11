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
          ./audio.nix
          (
            { pkgs, ... }:
            let
              fcp-tools = pkgs.callPackage ./fcp-support.nix { };
            in
            {
              environment.systemPackages = [
                # Call your local derivation file
                fcp-tools
              ];
              systemd.services."fcp-server@" = {
                enable = true;
                description = "Focusrite Control Protocol Server for Card %i";
                bindsTo = [ "dev-snd-controlC%i.device" ];

                serviceConfig = {
                  DynamicUser = "yes";
                  RuntimeDirectoryMode = 0770;
                  UMask = 0007;
                  Group = "audio";
                  RuntimeDirectory = "fcp-server-%i";
                  Type = "simple";
                  ExecStart = "${fcp-tools}/bin/fcp-server %i";
                  Restart = "on-failure";
                  AmbientCapabilities = "CAP_SYS_RAWIO";
                  CapabilityBoundingSet = "CAP_SYS_RAWIO";
                };
              };
              services.udev.extraRules = ''
                SUBSYSTEM=="sound", ATTRS{idVendor}=="1235", \
                    KERNEL=="control*", ACTION=="add", \
                    GROUP="audio", MODE="0660", \
                    ENV{SYSTEMD_WANTS}="fcp-server@%n.service", \
                    TAG+="systemd"
              '';

            }
          )
        ];
      };
    };
}
