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

		local kind_priorities = {
			Keyword = 1,
			Variable = 2,
			Function = 3,
			Method = 4,
			Field = 5,
			Constant = 6,
			Class = 7,
			Interface = 8,
			Module = 9,
			Property = 10,
			Unit = 11,
			Value = 12,
			Enum = 13,
			Snippet = 100,
			Text = 101,
		}

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
				['<CR>'] = cmp.mapping(
					function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
					{ 'i', 's' }
				),
				['<C-Space>'] = cmp.mapping(
					function()
						if cmp.visible() then
							cmp.close()
						else
							cmp.complete()
						end
					end,
					{ 'i', 'c' }
				),
				['<Down>'] = cmp.mapping.select_next_item(),
				['<Up>'] = cmp.mapping.select_prev_item()
			},
			sources = cmp.config.sources({ {
				name = 'nvim_lsp',
				priority = 1000
			}, {
				name = 'buffer',
				priority = 950,
				option = { get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end }
			}, {
				name = 'path',
				priority = 900
			} }),
			sorting = {
				comparators = {
					function(entry1, entry2)
						local kind1 = entry1:get_kind()
						local kind2 = entry2:get_kind()
						local priority1 = kind_priorities[kind1] or 1000
						local priority2 = kind_priorities[kind2] or 1000
						if priority1 ~= priority2 then
							return priority1 < priority2
						end
					end,
					cmp.config.compare.score,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order
				}
			}
		})
	end
}
