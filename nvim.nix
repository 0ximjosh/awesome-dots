{ inputs, ... }:
{
  home-manager.users.josh =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        inputs.nixneovimplugins.overlays.default
      ];

      programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
          typescript
          typescript-language-server
          prettierd
          nodePackages.prettier
          stylua
          nixd
          nixfmt-rfc-style
          lua-language-server
          gopls
        ];
        extraLuaConfig =
          builtins.readFile ./nvim/options.lua + builtins.readFile ./nvim/keymap.lua;
        plugins = with pkgs.vimPlugins; [
          vim-suda
          telescope-nvim
          nvim-web-devicons
          vim-just
          {
            plugin = pkgs.vimExtraPlugins.possession-nvim-jedrzejboczar;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/possession.lua;
          }
          {
            plugin = nvim-autopairs;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/auto-pairs.lua;
          }
          {
            plugin = nvim-surround;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/nvim-surround.lua;
          }
          {
            plugin = nvim-lint;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/vim-lint.lua;
          }
          {
            plugin = neo-tree-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/neo-tree.lua;
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/lualine.lua;
          }
          {
            plugin = indent-blankline-nvim;

            type = "lua";
            config = builtins.readFile ./nvim/plugins/indent-blankline.lua;
          }
          {
            plugin = blink-cmp;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/cmp.lua;
          }
          {
            plugin = go-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/go.lua;
          }
          {
            plugin = gitsigns-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/gitsigns.lua;
          }
          {
            plugin = tokyonight-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/tokyonight.lua;
          }
          {
            plugin = alpha-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/alpha-nvim.lua;
          }
          {
            plugin = nvim-treesitter.withAllGrammars;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/nvim-treesitter.lua;
          }
          {
            plugin = conform-nvim;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/conform.lua;
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = builtins.readFile ./nvim/plugins/lsp.lua;
          }
        ];
      };
    };
}
