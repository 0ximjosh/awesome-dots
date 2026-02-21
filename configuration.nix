# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  options,
  ...
}:

{
  # Hostname / Networking
  networking.hostName = "mira"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" ];
  networking.networkmanager.insertNameservers = [ "1.1.1.1" ];

  # Imports
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Nix Settings
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
    ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  # Cron jobs
  services.cron = {
    enable = true;
    systemCronJobs =
      let
        notPrefix = ''export XDG_RUNTIME_DIR=/run/user/$(id -u) && export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus" && ${pkgs.libnotify}/bin/notify-send "Go to bed Job"'';
      in
      [
        ''0 23 * * 0-4 josh ${notPrefix} "Shutting system down in one hour"''
        ''50 23 * * 0-4 josh ${notPrefix} "Shutting system down in 10 min"''
        "59 23 * * 0-4 root shutdown -h now"
        ''0 1 * * 6-7 josh ${notPrefix} hello "Shutting system down in one hour"''
        ''50 1 * * 6-7 josh ${notPrefix} hello "Shutting system down in one 10 min"''
        "59 1 * * 6-7 root shutdown -h now"
      ];
  };

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages =
    with pkgs;
    [
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      font-awesome
      fira-code
      fira-code-symbols
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      dejavu_fonts
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # Display Drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  hardware.graphics = {
    enable = true;
  };
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
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
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
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries =
    options.programs.nix-ld.libraries.default
    ++ (with pkgs; [
      dbus # libdbus-1.so.3
      fontconfig # libfontconfig.so.1
      freetype # libfreetype.so.6
      glib # libglib-2.0.so.0
      libGL # libGL.so.1
      libxkbcommon # libxkbcommon.so.0
      xorg.libX11 # libX11.so.6
      wayland
    ]);
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    custom = "$HOME/.oh-my-zsh/custom/";
    theme = "powerlevel10k/powerlevel10k";
  };
  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [
    { settings."org/gnome/desktop/interface".color-scheme = "prefer-dark"; }
  ];

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
  users.extraUsers.josh = {
    shell = pkgs.zsh;
  };
  users.users.josh = {
    isNormalUser = true;
    description = "josh";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  home-manager.users.josh =
    { pkgs, ... }:
    {
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
    bun
    obsidian
    piper
    libratbag
    jq
    libnotify
    just
    prismlauncher
    host
    dig
    google-chrome
    luajitPackages.luarocks_bootstrap
    ffmpeg
    yazi
    ninja
    nix-ld
    python315
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
