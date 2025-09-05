return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "eslint",
          "html",
          "cssls",
          "intelephense",
          "sqlls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- lua
      lspconfig.lua_ls.setup({})

      -- javascript / typescript
      lspconfig.ts_ls.setup({})

      -- eslint
      lspconfig.eslint.setup({})

      -- html
      lspconfig.html.setup({})

      -- css
      lspconfig.cssls.setup({})

      -- php
      lspconfig.intelephense.setup({})

      -- sql
      lspconfig.sqlls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
