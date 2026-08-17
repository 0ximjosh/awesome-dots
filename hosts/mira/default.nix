{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix.nix
    ../../modules/boot.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/graphics.nix
    ../../modules/desktop.nix
    ../../modules/users.nix
    ../../modules/programs.nix
    ../../modules/packages.nix
    ../../modules/virtualisation.nix
    ../../modules/media.nix
    ../../modules/cron.nix
  ];

  system.stateVersion = "25.11";
}
