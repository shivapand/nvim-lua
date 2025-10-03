return {
  "mason-org/mason-lspconfig.nvim",
  version = '*',
  dependencies = {
    {
      "mason-org/mason.nvim",
      version = '*',
      opts = {}
    },
    {
      "neovim/nvim-lspconfig",
      version = '*'
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      version = '*'
    }
  },
  config = function()
    require('mason-lspconfig').setup({
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        update_in_insert = true,
        virtual_text = false
      })
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        'lua-language-server',
        'stylua',
        'eslint-lsp',
        'typescript-language-server',
        'prettier',
        'emmet-language-server',
        'css-lsp',
        'stylelint-lsp'
      }
    })

    require('lspconfig').emmet_language_server.setup({
      filetypes = {
        "scss",
        "html",
        "javascript"
      }
    })

    -- ts_ls setup with proper root_dir detection
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    lspconfig.ts_ls.setup({
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = function(fname)
        return util.root_pattern("jsconfig.json", "tsconfig.json", "package.json")(fname)
            or util.find_git_ancestor(fname)
            or vim.loop.os_homedir()
      end,
    })
  end
}
