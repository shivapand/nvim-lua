vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.js", "*.jsx" },
  command = "set filetype=javascriptreact",
})
