{ pkgs, inputs, ... }:

{
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
      imports = [ inputs.nvim.homeManagerModules.default ];

      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
      };
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      home.sessionVariables.NIXOS_OZONE_WL = "1";
      programs.ghostty.enable = true;
      programs.firefox.enable = true;
      home.stateVersion = "25.11";
    };
}
