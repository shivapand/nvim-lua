return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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
      }),
      handlers = {
        function(server_name)
          local capabilities = require('blink.cmp').get_lsp_capabilities(
            vim.lsp.protocol.make_client_capabilities()
          )

          local server = servers[server_name] or {}

          server.capabilities = vim.tbl_deep_extend(
            'force', {}, capabilities, server.capabilities or {}
          )

          require('lspconfig')[server_name].setup(server)
        end,
      },

    })

    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, {
      'lua-language-server',
      'eslint-lsp',
      'typescript-language-server',
      'prettier',
      'emmet-language-server',
      'stylelint-lsp'
    })

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
  end
}
