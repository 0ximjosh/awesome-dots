{
  stdenv,
  lib,
  alsa-lib,
  openssl,
  zlib,
  json-c,
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
    rev = "master"; # Replace with a specific commit for reproducibility
    hash = lib.fakeHash; # Run 'nix build' once, then replace this with the real hash from the error
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    alsa-lib
    openssl
    zlib
    json-c
    systemd
  ];

  # The repo uses a standard Makefile
  installPhase = ''
    mkdir -p $out/bin $out/lib/systemd/system
    DESTDIR=$out make install
  '';

  meta = with lib; {
    description = "Linux FCP (Focusrite Control Protocol) Support Tools";
    homepage = "https://github.com/geoffreybennett/fcp-support";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
