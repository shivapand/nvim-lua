return {
  "olimorris/persisted.nvim",
  config = function()
    require('persisted').setup({
      autostart = true
    })
  end
}
