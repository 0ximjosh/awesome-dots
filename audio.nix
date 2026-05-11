{ pkgs, ... }:

let
  scarlett4AudioFirmware = pkgs.fetchzip {
    url = "https://github.com/geoffreybennett/scarlett4-firmware/archive/refs/tags/1.0.tar.gz";
    sha256 = "cef79425c665bb90b5ba85f7f483e41c2fdc1d4390e4c11344df1d69034e9cd5";
  };
in
{

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    (pkgs.runCommandNoCC "firmware-audio-scarlett" { } ''
      mkdir -p $out/lib/firmware
      cp ${scarlett4AudioFirmware}/firmware/* $out/lib/firmware/
    '')
  ];
}
