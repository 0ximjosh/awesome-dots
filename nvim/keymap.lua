local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local nnoremap = bind("n")

-- Toggle spell check
nnoremap("<leader>ss", ":set spell!<CR>", { silent = true })

-- Center screen on <Ctrl-[ud]>
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Clear search results
nnoremap("<leader>sc", ":noh<CR>")
nnoremap("<Esc>", ":noh<CR>")

-- Open terminal
nnoremap("<leader>t", ":terminal<CR>")

-- Telescope
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")

-- Open new tab
nnoremap("<leader><C-t>", ":tabnew<CR>")

-- Git
nnoremap("<leader>G", ":Neotree float git_status<CR>")
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")
nnoremap("<leader>gd", ":Gitsigns diffthis<CR>")

-- Misc helpers
nnoremap("<leader>p", '"0p<CR>')
nnoremap("<leader>ra", ":%s/")

-- LSP
nnoremap("<leader>e", vim.diagnostic.open_float)
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("<leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>fc", function()
      require("conform").format()
      vim.lsp.buf.format({ async = false })
    end, opts)
  end,
})
