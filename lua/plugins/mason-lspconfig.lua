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
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua-language-server',
        'eslint-lsp',
        'typescript-language-server',
        'prettier',
        'emmet-language-server',
        'css-lsp',
        'stylelint-lsp'
      },
      handlers = {
        -- Default handler for all servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- Special handler for emmet_language_server to disable completion
        ['emmet_language_server'] = function()
          local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
          emmet_capabilities.textDocument.completion = nil
          lspconfig.emmet_language_server.setup({
            filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescriptreact' },
            capabilities = emmet_capabilities,
          })
        end,
      },
    })

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
  end
}
