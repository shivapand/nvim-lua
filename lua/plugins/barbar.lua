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
    focus_on_close = 'left',
    icons = {
      button = false,
      separator = { left = '▎', right = '' },
      separator_at_end = false,
      preset = 'default',
      current = { buffer_index = true },
    },
    minimum_padding = 1,
    maximum_padding = 2
  },
  version = '^1.0.0'
}
