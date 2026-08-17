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
}
