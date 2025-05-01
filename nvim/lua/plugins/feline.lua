local c = {
  vim_mode = {
    provider = {
      name = "vi_mode",
      opts = {
        show_mode_name = true,
        -- padding = "center", -- Uncomment for extra padding.
      },
    },
    hl = function()
      return {
        fg = require("feline.providers.vi_mode").get_mode_color(),
        bg = "darkblue",
        style = "bold",
        name = "NeovimModeHLColor",
      }
    end,
    left_sep = "block",
    right_sep = "block",
  },
  gitBranch = {
    provider = "git_branch",
    hl = {
      fg = "peanut",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitRemote = {
    provider = "git_remote",
    hl = {
      fg = "peanut",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitDiffAdded = {
    provider = "git_diff_added",
    hl = {
      fg = "green",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitDiffRemoved = {
    provider = "git_diff_removed",
    hl = {
      fg = "red",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitDiffChanged = {
    provider = "git_diff_changed",
    hl = {
      fg = "fg",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "right_filled",
  },
  separator = {
    provider = "",
  },
  fileinfo = {
    provider = {
      name = "file_info",
      opts = {
        type = "relative-short",
      },
    },
    hl = {
      style = "bold",
    },
    left_sep = " ",
    right_sep = " ",
  },
  diagnostic_errors = {
    provider = "diagnostic_errors",
    hl = {
      fg = "red",
    },
  },
  diagnostic_warnings = {
    provider = "diagnostic_warnings",
    hl = {
      fg = "yellow",
    },
  },
  diagnostic_hints = {
    provider = "diagnostic_hints",
    hl = {
      fg = "aqua",
    },
  },
  diagnostic_info = {
    provider = "diagnostic_info",
  },
  lsp_client_names = {
    provider = "lsp_client_names",
    hl = {
      fg = "purple",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "left_filled",
    right_sep = "block",
  },
  file_type = {
    provider = {
      name = "file_type",
      opts = {
        filetype_icon = true,
        case = "titlecase",
      },
    },
    hl = {
      fg = "red",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  file_encoding = {
    provider = "file_encoding",
    hl = {
      fg = "orange",
      bg = "darkblue",
      style = "italic",
    },
    left_sep = "block",
    right_sep = "block",
  },
  position = {
    provider = "position",
    hl = {
      fg = "green",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  line_percentage = {
    provider = "line_percentage",
    hl = {
      fg = "aqua",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  scroll_bar = {
    provider = "scroll_bar",
    hl = {
      fg = "yellow",
      style = "bold",
    },
  },
}

local left = {
  c.gitBranch,
  c.gitRemote,
  c.gitDiffAdded,
  c.gitDiffRemoved,
  c.gitDiffChanged,
  c.separator,
}

local middle = {
  c.fileinfo,
  c.diagnostic_errors,
  c.diagnostic_warnings,
  c.diagnostic_info,
  c.diagnostic_hints,
}

local right = {
  c.lsp_client_names,
  c.file_type,
  c.position,
}

--return {
--  "freddiehaddad/feline.nvim",
--  event = "CmdlineEnter",
--  dependencies = { "lewis6991/gitsigns.nvim" },
--  config = function()
--    local feline = require("feline")
--    feline.setup({
--      custom_providers = {
--        git_remote = function()
--          local branch = vim.system({
--                "git",
--                "rev-parse",
--                "--abbrev-ref",
--                "--symbolic-full-name",
--                "@{u}",
--              })
--              :wait().stdout
--              :sub(1, -2)
--          if branch == nil then
--            return ""
--          end
--          return branch
--        end,
--      },
--      components = {
--        active = {
--          left,
--          middle,
--          right,
--        },
--        inactive = {
--          left,
--          middle,
--          right,
--        },
--      },
--      theme = {
--        fg = "#abb2bf",
--        bg = "#1e2024",
--        green = "#98c379",
--        yellow = "#e5c07b",
--        purple = "#c678dd",
--        orange = "#d19a66",
--        peanut = "#f6d5a4",
--        red = "#e06c75",
--        aqua = "#61afef",
--        darkblue = "#282c34",
--        dark_red = "#f75f5f",
--      },
--      vi_mode_colors = {
--        NORMAL = "green",
--        OP = "green",
--        INSERT = "yellow",
--        VISUAL = "purple",
--        LINES = "orange",
--        BLOCK = "dark_red",
--        REPLACE = "red",
--        COMMAND = "aqua",
--      },
--    })
--    feline.winbar.setup()
--  end,
--}
