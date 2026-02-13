require("conform").setup({
  formatters = {
    mdformat = {
      prepend_args = { "--wrap", "80" },
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    typescript = { "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    markdown = { "mdformat" },
  },
})
