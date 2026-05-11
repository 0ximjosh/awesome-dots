{ pkgs, ... }:

let
  scarlett4AudioFirmware = pkgs.fetchzip {
    url = "https://github.com/geoffreybennett/scarlett4-firmware/archive/refs/tags/1.0.tar.gz";
    sha256 = "QVeUB8pxuYywyTEwAo2KT5+GhbxNEfECKPz2yox93iU=";
  };
in
{

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    (pkgs.runCommand "firmware-audio-scarlett" { } ''
      mkdir -p $out/lib/firmware
      cp ${scarlett4AudioFirmware}/firmware/* $out/lib/firmware/
    '')
  ];
}
