local dashboard = require("alpha.themes.dashboard")
-- Footer
local function footer()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local datetime = os.date("%Y/%m/%d %H:%M:%S")

  return print_version .. " - " .. datetime
end

-- Banner
local banner = {
  "                                                    ",
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                    ",
}

dashboard.section.header.val = banner

local workspace_button = nil
local session_name = vim.fn.fnamemodify(vim.loop.cwd(), ":t")
local session_path = vim.fn.stdpath("data") .. "/possession/" .. session_name .. ".json"
if vim.fn.filereadable(session_path) == 1 then
  workspace_button = dashboard.button("l", "⟳  Load Workspace", function()
    vim.cmd(":PossessionLoad " .. session_name)
  end)
end

-- Menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("g", "  Grep word", ":Telescope live_grep<CR>"),
  workspace_button,
  dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

dashboard.section.footer.val = footer()
require("alpha").setup(dashboard.config)
