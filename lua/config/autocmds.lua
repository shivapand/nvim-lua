vim.o.updatetime = 300

vim.api.nvim_create_autocmd('CursorHold', {
	group = vim.api.nvim_create_augroup('LspSagaDiagnostics', { clear = true }),
	command = 'Lspsaga show_cursor_diagnostics ++unfocus',
	desc = 'Show LSP diagnostics on cursor hold'
})
