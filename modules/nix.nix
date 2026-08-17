{ lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "1password-gui"
      "1password"
      "cursor"
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.extra-substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
}
