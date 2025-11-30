return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'onsails/lspkind-nvim' -- icons
	},
	config = function()
		local cmp = require('cmp')
		local lspkind = require('lspkind')

		cmp.setup({
			completion = { completeopt = 'menu,menuone,select' },
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered()
			},
			formatting = { format = lspkind.cmp_format({
				mode = 'symbol_text',
				maxwidth = 50
			}) },
			mapping = {
				['<CR>'] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Replace
				}),
				['<C-e>'] = cmp.mapping(
					function(fallback)
						if cmp.visible() then
							cmp.close()
						else
							cmp.complete()
						end
					end,
					{ 'i', 's' }
				),
				['<Down>'] = cmp.mapping.select_next_item(),
				['<Up>'] = cmp.mapping.select_prev_item()
			},
			sources = cmp.config.sources({ {
				name = 'nvim_lsp',
				priority = 1000
			}, {
				-- nvim_lsp is now highest
				name = 'buffer',
				priority = 950
			}, {
				name = 'path',
				priority = 900
			} }),
			experimental = { ghost_text = true },
			sorting = {
				priority_weight = 2,
				comparators = { cmp.config.compare.exact }
			}
		})
	end
}
