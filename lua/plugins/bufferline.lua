return {
  'akinsho/bufferline.nvim',
  config = function()
    require('bufferline').setup({
      options = {
        mode = "tabs",
        max_name_length = 40,
        max_prefix_length = 40,
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
      }
    })
  end
}
