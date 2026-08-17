{ nixneovimplugins }:
{ pkgs, ... }:
{
  nixpkgs.overlays = [ nixneovimplugins.overlays.default ];

  programs.neovim = {
    enable = true;
  }
  // import ./neovim.nix { inherit pkgs; };
}
