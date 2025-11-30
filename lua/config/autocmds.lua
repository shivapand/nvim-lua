vim.o.updatetime = 300

vim.api.nvim_create_autocmd('CursorHold', {
	group = vim.api.nvim_create_augroup('LspSagaDiagnostics', { clear = true }),
	command = 'Lspsaga show_cursor_diagnostics ++unfocus',
	desc = 'Show LSP diagnostics on cursor hold'
})

vim.api.nvim_create_autocmd(
	{ 'FocusGained', 'BufEnter', 'VimResume', 'CursorHold' },
	{
		group = vim.api.nvim_create_augroup('AutoRead', { clear = true }),
		pattern = '*',
		command = 'checktime',
		desc = 'Check for file changes'
	}
)

