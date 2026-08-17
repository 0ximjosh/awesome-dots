{
  stdenv,
  lib,
  alsa-lib,
  openssl,
  zlib,
  json_c,
  systemd,
  pkg-config,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "fcp-support";
  version = "unstable"; # Or use a specific commit hash

  src = fetchFromGitHub {
    owner = "geoffreybennett";
    repo = "fcp-support";
    rev = "master";
    sha256 = "U1FpnJr+xydwocpcZB+xu9QwBoXq22gMMJBaSaXspac=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    alsa-lib
    openssl
    zlib
    json_c
    systemd
  ];

  # The repo uses a standard Makefile
  installPhase = ''
    mkdir -p $out/bin $out/lib/systemd/system
    PREFIX=$out make install
  '';

  meta = with lib; {
    description = "Linux FCP (Focusrite Control Protocol) Support Tools";
    homepage = "https://github.com/geoffreybennett/fcp-support";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
