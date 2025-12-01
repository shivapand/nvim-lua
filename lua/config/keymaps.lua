vim.keymap.set({ 'i', 'n' }, '<C-s>', '<ESC>:silent w<CR>', {
	desc = 'Save file',
	silent = true
})

vim.keymap.set('n', '<Leader>/', ':noh<CR>', {
	desc = 'Clear search highlight',
	silent = true
})

vim.keymap.set(
	'n',
	'<Leader>g',
	function()
		vim.fn.setreg('+', vim.fn.expand('%:~:.'))
	end,
	{
		desc = 'Copy file path',
		silent = true
	}
)

vim.keymap.set('n', '<Leader>j', ':execute "tabmove" tabpagenr() - 2<CR>', {
	desc = 'Move tab prev'
})
vim.keymap.set('n', '<Leader>k', ':execute "tabmove" tabpagenr() + 1<CR>', {
	desc = 'Move tab next'
})

vim.keymap.set(
	'n',
	'-',
	function()
		if vim.bo.filetype == 'nerdtree' then
			-- If in NERDTree, go up one directory
			vim.cmd('call nerdtree#ui_glue#invokeKeyMap("u")')
		else
			-- If not in NERDTree, toggle it
			-- Use current directory if no file is open
			if vim.fn.expand('%') == '' then
				vim.cmd('NERDTreeToggle .')
			else
				vim.cmd('NERDTreeToggle%')
			end
		end
	end,
	{ desc = 'NERDTree toggle or go up directory' }
)

vim.keymap.set('n', '_', ':NERDTree<CR>', { desc = 'NERDTree root directory' })

vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>', {
	desc = 'Toggle NERDTree'
})

vim.keymap.set(
	'n',
	'<C-t>',
	function()
		if vim.bo.filetype == 'nerdtree' then
			-- 't' opens the file in a new tab and switches to it.
			vim.cmd('call nerdtree#ui_glue#invokeKeyMap("t")')
			-- Go back to the previous tab, which should be the NERDTree tab.
			vim.cmd('tabprevious')
			-- Close the NERDTree window.
			vim.cmd('NERDTreeClose')
			-- Go to the next tab, which should be the newly opened file.
			vim.cmd('tabnext')
		else
			-- If not in NERDTree, use normal Ctrl-t behavior
			vim.cmd('tabnew')
		end
	end,
	{ desc = 'Open in new tab (Ctrl-t in NERDTree, normal tabnew elsewhere)' }
)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kickstart-lsp-attach', {
		clear = true
	}),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or 'n'

			vim.keymap.set(mode, keys, func, {
				buffer = event.buf,
				desc = 'LSP: ' .. desc
			})
		end

		map('gn', vim.lsp.buf.rename, '[R]e[n]ame')

		map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

		map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')

		map(
			'gi',
			require('fzf-lua').lsp_implementations,
			'[G]oto [I]mplementation'
		)

		map(
			'gd',
			function()
				vim.lsp.buf.definition({ on_list = function(options)
					if #options.items > 1 then
						vim.notify(
							'Multiple items found, opening first one',
							vim.log.levels.WARN
						)
					end

					vim.cmd('tab split')
					vim.lsp.buf.definition()
				end })
			end,
			'[G]oto [D]efinition'
		)

		map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

		map(
			'gO',
			require('fzf-lua').lsp_document_symbols,
			'Open Document Symbols'
		)

		map(
			'gW',
			require('fzf-lua').lsp_live_workspace_symbols,
			'Open Workspace Symbols'
		)

		map('gt', require('fzf-lua').lsp_typedefs, '[G]oto [T]ype Definition')
	end
})

vim.keymap.set(
	'n',
	'[g',
	function()
		vim.diagnostic.goto_prev({ float = false })
	end,
	{ desc = 'Previous Diagnostic' }
)
vim.keymap.set(
	'n',
	']g',
	function()
		vim.diagnostic.goto_next({ float = false })
	end,
	{ desc = 'Next Diagnostic' }
)

vim.keymap.set('n', '<S-k>', '<Cmd>Lspsaga hover_doc<CR>', {
	desc = 'Hover Doc'
})

vim.keymap.set(
	{ 'n', 'v' },
	'<C-a>',
	function()
		require('conform').format({ lsp_format = 'fallback' })
	end,
	{ desc = 'Format current file' }
)
