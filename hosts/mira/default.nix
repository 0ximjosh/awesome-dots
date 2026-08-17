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

  # WD Black SN750 SE 1TB, reformatted from the Windows "Docks" data disk.
  fileSystems."/data" = {
    device = "/dev/disk/by-label/nix-data";
    fsType = "ext4";
    options = [
      "noatime"
      "nofail"
      "x-systemd.device-timeout=5s"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /data 0755 josh users -"
  ];

  system.stateVersion = "25.11";
}
