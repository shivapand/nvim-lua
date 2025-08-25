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
        "javascript",
      }
    })
  end
}
