{ pkgs }:

{
  extraPackages = with pkgs; [
    typescript
    tailwindcss-language-server
    systemd-language-server
    pyright
    typescript-language-server
    dockerfile-language-server
    yaml-language-server
    bash-language-server
    prettierd
    nodePackages.prettier
    stylua
    nixd
    nixfmt-rfc-style
    lua-language-server
    gopls
  ];

  extraLuaConfig = builtins.readFile ./options.lua + builtins.readFile ./keymap.lua;

  plugins = with pkgs.vimPlugins; [
    vim-suda
    telescope-nvim
    nvim-web-devicons
    vim-just
    {
      plugin = pkgs.vimExtraPlugins.possession-nvim-jedrzejboczar;
      type = "lua";
      config = builtins.readFile ./plugins/possession.lua;
    }
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = builtins.readFile ./plugins/auto-pairs.lua;
    }
    {
      plugin = nvim-ts-autotag;
      type = "lua";
      config = builtins.readFile ./plugins/ts-autotag.lua;
    }
    {
      plugin = nvim-surround;
      type = "lua";
      config = builtins.readFile ./plugins/nvim-surround.lua;
    }
    {
      plugin = nvim-lint;
      type = "lua";
      config = builtins.readFile ./plugins/vim-lint.lua;
    }
    {
      plugin = neo-tree-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/neo-tree.lua;
    }
    {
      plugin = lualine-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/lualine.lua;
    }
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/indent-blankline.lua;
    }
    {
      plugin = blink-cmp;
      type = "lua";
      config = builtins.readFile ./plugins/cmp.lua;
    }
    {
      plugin = go-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/go.lua;
    }
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/gitsigns.lua;
    }
    {
      plugin = tokyonight-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/tokyonight.lua;
    }
    {
      plugin = alpha-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/alpha-nvim.lua;
    }
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = builtins.readFile ./plugins/nvim-treesitter.lua;
    }
    {
      plugin = conform-nvim;
      type = "lua";
      config = builtins.readFile ./plugins/conform.lua;
    }
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = builtins.readFile ./plugins/lsp.lua;
    }
  ];
}
