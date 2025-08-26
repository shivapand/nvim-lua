return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    animation = false,
    tabpages = false,
    clickable = true,
    icons = {
      button = false,
      separator = {left = '▎', right = ''},
      separator_at_end = true,
      preset = 'default',
      current = { buffer_index = true },
    }
  },
  version = '^1.0.0'
}
