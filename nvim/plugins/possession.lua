require("possession").setup({
  autosave = {
    tmp = true,
    tmp_name = function()
      return vim.fn.fnamemodify(vim.loop.cwd(), ":t")
    end,
    on_quit = true,
  },
  hooks = {
    before_save = function()
      -- Dont save git buffers
      return vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h:t") ~= ".git"
    end,
  },
})
