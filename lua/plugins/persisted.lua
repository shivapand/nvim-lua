return {
  "olimorris/persisted.nvim",
  config = function()
    require('persisted').setup({
      autostart = false
    })
  end
}
