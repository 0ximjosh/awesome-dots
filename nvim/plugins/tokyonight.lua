require("tokyonight").setup({
	transparent = true, -- Enable this to disable setting the background color
	styles = {
	sidebars = "transparent", -- style for sidebars, see below
	},
})
vim.opt.background = "dark"
vim.cmd.colorscheme("tokyonight")
