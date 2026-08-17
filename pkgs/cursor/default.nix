{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
}:

let
  sources = lib.importJSON ./sources.json;
  pname = "cursor";
  inherit (sources) version;

  srcInfo =
    sources.sources.${stdenv.hostPlatform.system} or (throw "cursor: unsupported system ${stdenv.hostPlatform.system}");

  src = fetchurl {
    inherit (srcInfo) url hash;
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      rm -f "$out/usr/share/cursor/resources/appimageupdatetool.AppImage" \
        "$out/resources/appimageupdatetool.AppImage" || true
    '';
  };
in
appimageTools.wrapAppImage {
  inherit pname version;
  src = appimageContents;

  extraPkgs =
    pkgs: with pkgs; [
      libsecret
      libappindicator-gtk3
    ];

  extraBwrapArgs = [
    "--setenv CURSOR_DISABLE_UPDATE 1"
    "--setenv ELECTRON_OZONE_PLATFORM_HINT auto"
  ];

  extraInstallCommands = ''
    if [ -e "$out/bin/${pname}-${version}" ]; then
      mv "$out/bin/${pname}-${version}" "$out/bin/${pname}"
    fi

    mkdir -p "$out/share/applications" "$out/share/pixmaps" "$out/share/icons"

    desktop_src=""
    for candidate in \
      ${appimageContents}/cursor.desktop \
      ${appimageContents}/usr/share/applications/cursor.desktop \
      ${appimageContents}/usr/share/applications/co.anysphere.cursor.desktop
    do
      if [ -f "$candidate" ]; then
        desktop_src="$candidate"
        break
      fi
    done

    if [ -n "$desktop_src" ]; then
      install -Dm644 "$desktop_src" "$out/share/applications/cursor.desktop"
      sed -i \
        -e 's|^Exec=.*|Exec=cursor %F|' \
        -e 's|^Icon=.*|Icon=cursor|' \
        "$out/share/applications/cursor.desktop"
    fi

    if [ -d ${appimageContents}/usr/share/icons ]; then
      cp -a ${appimageContents}/usr/share/icons/. "$out/share/icons/"
    fi

    for icon in \
      ${appimageContents}/cursor.png \
      ${appimageContents}/usr/share/pixmaps/cursor.png \
      ${appimageContents}/usr/share/pixmaps/co.anysphere.cursor.png
    do
      if [ -f "$icon" ]; then
        install -Dm644 "$icon" "$out/share/pixmaps/cursor.png"
        break
      fi
    done
  '';

  passthru = {
    inherit src;
    updateScript = ./update.sh;
  };

  meta = {
    description = "AI-powered code editor built on VS Code";
    homepage = "https://cursor.com";
    changelog = "https://cursor.com/changelog";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    mainProgram = "cursor";
  };
}
