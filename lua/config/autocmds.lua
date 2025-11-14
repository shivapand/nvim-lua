vim.o.updatetime = 300

vim.api.nvim_create_autocmd('CursorHold', {
	group = vim.api.nvim_create_augroup('LspSagaDiagnostics', { clear = true }),
	command = 'Lspsaga show_cursor_diagnostics ++unfocus',
	desc = 'Show LSP diagnostics on cursor hold'
})

-- Refresh buffer when switching tabs to trigger linter
vim.api.nvim_create_autocmd('TabEnter', {
	group = vim.api.nvim_create_augroup('RefreshOnTabSwitch', { clear = true }),
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(bufnr)
		-- Only refresh file buffers that have a filename
		if vim.bo[bufnr].buftype == '' and filename ~= '' then
			vim.cmd('e!')
		end
	end,
	desc = 'Refresh buffer when switching tabs'
})
