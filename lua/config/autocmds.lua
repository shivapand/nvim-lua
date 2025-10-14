vim.api.nvim_create_autocmd('BufReadPost', {
	group = vim.api.nvim_create_augroup('OilRelativePathFix', { clear = true }),
	callback = function()
		vim.cmd('cd `pwd`')
	end,
	desc = 'Fix for Oil opening files with absolute-path'
})

vim.o.updatetime = 300

vim.api.nvim_create_autocmd('CursorHold', {
	group = vim.api.nvim_create_augroup('LspSagaDiagnostics', { clear = true }),
	command = 'Lspsaga show_cursor_diagnostics ++unfocus',
	desc = 'Show LSP diagnostics on cursor hold'
})

-- go to left tab when closing one
vim.api.nvim_create_autocmd('TabClosed', { callback = function(args)
	-- get the index of the last closed tab
	local closed = tonumber(args.file)
	local total = vim.fn.tabpagenr('$')
	local prev = closed - 1

	-- focus left tab if exists, else fallback to rightmost
	if prev >= 1 then
		vim.cmd('tabnext ' .. prev)
	elseif total > 0 then
		vim.cmd('tabnext ' .. total)
	end
end })
