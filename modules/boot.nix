{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.enable = true;
  boot.loader.grub.configurationLimit = 5;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
    screen = "2k";
  };
}
