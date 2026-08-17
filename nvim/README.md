# Neovim

Standalone Neovim flake, also imported by the NixOS config via home-manager.

### Featuring

* Telescope for jumping between files
* Tokyonight as a theme
* neo-tree as filetree
* Treesitter, LSP, blink.cmp, conform, and lualine

### Usage

```bash
# Run this config without installing it
nix run ./nvim

# Build the wrapped neovim package
nix build ./nvim
```

From home-manager:

```nix
{
  inputs.nvim.url = "path:./nvim"; # or a git url with ?dir=nvim

  # ...
  home-manager.users.josh.imports = [
    inputs.nvim.homeManagerModules.default
  ];
}
```

### Layout

- Core settings in `options.lua` and `keymap.lua`
- Plugin settings in `plugins/*`
- Shared Nix config in `neovim.nix`
