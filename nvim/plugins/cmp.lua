require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<TAB>"] = { "select_next", "fallback" },
    ["<S-TAB>"] = { "select_prev", "fallback" },
    ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide" },
    ["<CR>"] = { "accept", "fallback" },
  },

  completion = {
    list = {
      selection = { preselect = true, auto_insert = true },
    },
    menu = {
      border = nil,
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = nil,
      },
    },
  },

  sources = {
    default = { "lsp", "path", "buffer" },
  },
})
