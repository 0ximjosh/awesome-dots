return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
      },
    })
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
    local ensure_installed = {
      "lua_ls",
      "astro",
      "bashls",
      "dockerls",
      "eslint",
      "ts_ls",
      "marksman",
      "tailwindcss",
      "yamlls",
    }
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    lspconfig.pyright.setup({})
    --lspconfig.solidity_ls_nomicfoundation.setup({})
    --lspconfig.solidity_ls.setup({
    --  capabilities = capabilities,
    --  cmd = { "vscode-solidity-server", "--stdio" },
    --  filetypes = { "solidity" },
    --})
    lspconfig.gopls.setup({
      capabilities = capabilities,
      settings = {
        gopls = {
          buildFlags = { "-tags=integration" },
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })
    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    for _, lsp in ipairs(ensure_installed) do
      lspconfig[lsp].setup({
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
      })
    end
  end,
}
