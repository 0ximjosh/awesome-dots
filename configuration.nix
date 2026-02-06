# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  # Hostname / Networking
  networking.hostName = "mira"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Imports
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Nix Settings
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "1password-gui"
      "1password"
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
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

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    font-awesome
    fira-code
    fira-code-symbols
    noto-fonts
  ];

  # Display Drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  hardware.graphics = { enable = true; };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Docker env
  virtualisation.docker.enable = true;

  # Programs
  programs.waybar.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "josh" ];
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh = { enable = true; };
  programs.zsh.ohMyZsh = {
    enable = true;
    custom = "$HOME/.oh-my-zsh/custom/";
    theme = "powerlevel10k/powerlevel10k";
  };


  # TZ / Keyboard
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.josh = { shell = pkgs.zsh; };
  users.users.josh = {
    isNormalUser = true;
    description = "josh";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  home-manager.users.josh = { pkgs, ... }: {
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    wayland.windowManager.hyprland.enable = true;
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.ghostty.enable = true;
    programs.firefox.enable = true;
    wayland.windowManager.hyprland.systemd.enable = false;
    home.stateVersion = "25.11";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spotify
    discord
    vim
    git
    adwaita-icon-theme
    zsh-powerlevel10k
    meslo-lgs-nf
    nodejs_24
    direnv
    go
    gopls
    uv
    golines
    iferr
    gotools
    gotests
    richgo
    reftools
    ginkgo
    gotestsum
    gofumpt
    gomodifytags
    impl
    govulncheck
    mockgen
    python315
    lua
    gcc
    unzip
    wget
    rustup
    ripgrep
    wofi
    keychain
    oh-my-zsh
    eza
    fzf
    fd
    gnugrep
    neofetch
    hyprshot
    wpaperd
    hyprpicker
    swaynotificationcenter
    hyprpolkitagent
    tree-sitter
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
