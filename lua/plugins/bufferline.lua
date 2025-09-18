return {
  'akinsho/bufferline.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function ()
    require("bufferline").setup {
      options = {
        mode = "tabs",
        numbers = "ordinal",
        show_close_icon = false,
        show_buffer_close_icons = false,
        diagnostics = 'coc',
        diagnostics_update_in_insert = true
      }
    }
  end
}
