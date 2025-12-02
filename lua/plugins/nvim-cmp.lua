return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lsp'
	},
	config = function()
		local cmp = require('cmp')

		cmp.setup({
			completion = { completeopt = 'menu,menuone' },
			preselect = cmp.PreselectMode.None,
			mapping = cmp.mapping.preset.insert({
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true })
			}),
			sources = cmp.config.sources({ {
				name = 'nvim_lsp',
				priority = 1000
			}, {
				name = 'buffer',
				priority = 750,
				option = { get_bufnrs = vim.api.nvim_list_bufs }
			}, {
				name = 'path',
				priority = 500
			} }),
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.score, -- Most important: LSP/score relevance
					cmp.config.compare.exact, -- Exact match boost
					cmp.config.compare.recently_used, -- Move used items up
					cmp.config.compare.locality, -- Closer buffer items rank higher
					cmp.config.compare.kind, -- Sort by item type (function > variable etc.)
					cmp.config.compare.sort_text, -- Sort by language server provided sortText
					cmp.config.compare.length, -- Shorter words slightly earlier
					cmp.config.compare.order
				}
			}
		})
	end
}
