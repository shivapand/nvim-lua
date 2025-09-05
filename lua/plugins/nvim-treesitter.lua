return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require 'nvim-treesitter.configs'.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

      sync_install = false,

      auto_install = true,

      highlight = {
        enable = true
      },
      indent = {
        enable = false
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,

          lookahead = true,

          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>'
          },
          include_surrounding_whitespace = true,
        },
      },
      modules = {},
      ignore_install = {},
    })
  end
}
