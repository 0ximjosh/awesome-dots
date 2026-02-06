return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  config = function()
    local configs = require("nvim-treesitter")
    configs.install({ "tsx", "lua", "typescript" })
    require("nvim-ts-autotag").setup()
  end,
}
