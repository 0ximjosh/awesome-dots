{ lib, pkgs, ... }:

{
  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [
    { settings."org/gnome/desktop/interface".color-scheme = "prefer-dark"; }
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.polkit.enable = true;

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

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
