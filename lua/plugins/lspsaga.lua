return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      lightbulb = {
        enable = false
      },
      diagnostic = {
        show_code_action = false,
      }
    })
  end,
}
