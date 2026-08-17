{ options, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "josh" ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries =
    options.programs.nix-ld.libraries.default
    ++ (with pkgs; [
      dbus
      fontconfig
      freetype
      glib
      libGL
      libxkbcommon
      xorg.libX11
      wayland
    ]);

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    custom = "$HOME/.oh-my-zsh/custom/";
    theme = "powerlevel10k/powerlevel10k";
  };
}
