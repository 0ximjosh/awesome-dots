require("nvim-treesitter.configs").setup({
  -- Grammars are installed via Nix (nvim-treesitter.withAllGrammars)
  -- so we don't need ensure_installed

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
