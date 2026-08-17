{ lib, pkgs, inputs, ... }:

let
  hypr = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  # Input 1 on the Scarlett 4i4 (FL). Serial is stable for this interface.
  scarlettInput = "alsa_input.usb-Focusrite_Scarlett_4i4_4th_Gen_S439AE4618A79B-00.analog-surround-21";
in
{
  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = hypr.hyprland;
    portalPackage = hypr.xdg-desktop-portal-hyprland;
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

    # Scarlett 4i4 exposes Analog Surround 2.1 (FL/FR/LFE). A mono mic on
    # input 1 only has signal on FL, so apps that capture "stereo" hear one
    # channel (or a quieter downmix). Publish a dedicated mono source with a
    # persistent 75% gain boost (1.75x).
    extraConfig.pipewire."51-focusrite-mono-mic" = {
      "context.modules" = [
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Focusrite Mic";
            "media.name" = "Focusrite Mic";
            "filter.graph" = {
              nodes = [
                {
                  type = "builtin";
                  name = "gain";
                  label = "mixer";
                  control = {
                    "Gain 1" = 1.75;
                  };
                }
              ];
              inputs = [ "gain:In 1" ];
              outputs = [ "gain:Out" ];
            };
            "capture.props" = {
              "node.name" = "capture.focusrite-mic";
              "audio.channels" = 1;
              "audio.position" = [ "FL" ];
              "stream.dont-remix" = true;
              "target.object" = scarlettInput;
              "node.dont-fallback" = true;
              "node.passive" = true;
            };
            "playback.props" = {
              "node.name" = "focusrite-mic-mono";
              "node.description" = "Focusrite Mic";
              "media.class" = "Audio/Source";
              "audio.channels" = 1;
              "audio.position" = [ "MONO" ];
              "priority.session" = 3000;
            };
          };
        }
      ];
    };

    wireplumber.extraConfig."51-focusrite-mono-mic" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            { "node.name" = "~alsa_input.usb-Focusrite_Scarlett_4i4_4th_Gen_.*"; }
          ];
          actions = {
            update-props = {
              "priority.session" = 500;
            };
          };
        }
      ];
    };
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
