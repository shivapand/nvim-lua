return {
  'jlanzarotta/bufexplorer',
  config = function()
    vim.keymap.set("n", "<S-w>", ":BufExplorer<CR>", {desc = 'Toggle BufExplorer'})
  end,
}
