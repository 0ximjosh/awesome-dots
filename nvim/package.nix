{
  pkgs,
  lib,
}:

let
  cfg = import ./neovim.nix { inherit pkgs; };

  pluginLua = lib.concatMapStrings (
    plugin:
    if plugin ? config && (plugin.type or "viml") == "lua" then
      plugin.config + "\n"
    else
      ""
  ) cfg.plugins;

  plugins = map (plugin: if plugin ? plugin then plugin.plugin else plugin) cfg.plugins;
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
  inherit plugins;
  wrapRc = true;
  withNodeJs = true;
  luaRcContent = cfg.extraLuaConfig + "\n" + pluginLua;
  wrapperArgs = "--prefix PATH : ${lib.makeBinPath cfg.extraPackages}";
}
