local g = vim.g     -- a table to access global variables
local opt = vim.opt -- to set options
local api = vim.api

g.mapleader = ","
g.maplocalleader = " "

-- coc Config
opt.signcolumn = "number"
opt.updatetime = 300
opt.cmdheight = 2

-- base nvim config
opt.expandtab = true   -- Use spaces instead of tabs
opt.hidden = true      -- Enable background buffers
opt.ignorecase = true  -- Ignore case
opt.joinspaces = false -- No double spaces with join
opt.number = true      -- Show line numbers
opt.scrolloff = 4      -- Lines of context
opt.shiftround = true  -- Round indent
opt.shiftwidth = 4     -- Size of an indent
opt.sidescrolloff = 8  -- Columns of context
opt.smartcase = true   -- Do not ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true  -- Put new windows below current
opt.splitright = true  -- Put new windows right of current
opt.tabstop = 2        -- Number of spaces tabs count for
opt.softtabstop = 2    -- Soft tab stop
opt.shiftwidth = 2
opt.incsearch = true
opt.relativenumber = true     -- relative line numbers
opt.termguicolors = true      -- True color support
opt.clipboard = "unnamedplus" -- set clipboard to yank
g.wildmenu = false
opt.cursorline = true

opt.wrap = false     -- Disable line wrap
opt.mouse = "a"      -- make mouse usable
opt.laststatus = 3   -- keep buffer open
opt.shell = "zsh"    -- use zsh shell
opt.spelllang = "en" -- language for spell checker
opt.spellsuggest = "best, 9"
opt.undofile = true  -- Unlimited undos!!!

opt.colorcolumn = "80"

vim.filetype.add({ extension = { mdx = "mdx" } })

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command("augroup " .. group_name)
    api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      api.nvim_command(command)
    end
    api.nvim_command("augroup END")
  end
end

local autocmds = {
  terminal_job = {
    { "TermOpen", "*",        [[tnoremap <buffer> <Esc> <c-\><c-n>]] },
    { "TermOpen", "*",        "startinsert" },
    { "TermOpen", "*",        "setlocal listchars= nonumber norelativenumber nocursorline" },
    { "BufLeave", "term://*", "stopinsert" },
  },
}

nvim_create_augroups(autocmds)
