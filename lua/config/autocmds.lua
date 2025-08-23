vim.opt.updatetime = 500

vim.api.nvim_create_augroup("LspSagaDiagnostics", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
  group = "LspSagaDiagnostics",
  command = 'Lspsaga show_cursor_diagnostics ++unfocus',
  desc = "Show LSP diagnostics on cursor hold",
})
