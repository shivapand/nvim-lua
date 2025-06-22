return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  config = function(_)
    require('lualine').setup({})
  end,
}
