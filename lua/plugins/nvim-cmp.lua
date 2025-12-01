return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'onsails/lspkind-nvim'
	},
	config = function()
		local cmp = require('cmp')
		local lspkind = require('lspkind')
		local CompletionItemKind = vim.lsp.protocol.CompletionItemKind

		-- Kind priorities (use numeric enum keys)
		local kind_priorities = {
			[CompletionItemKind.Keyword] = 1,
			[CompletionItemKind.Variable] = 2,
			[CompletionItemKind.Function] = 3,
			[CompletionItemKind.Method] = 4,
			[CompletionItemKind.Field] = 5,
			[CompletionItemKind.Constant] = 6,
			[CompletionItemKind.Class] = 7,
			[CompletionItemKind.Interface] = 8,
			[CompletionItemKind.Module] = 9,
			[CompletionItemKind.Property] = 10,
			[CompletionItemKind.Unit] = 11,
			[CompletionItemKind.Value] = 12,
			[CompletionItemKind.Enum] = 13,
			[CompletionItemKind.Snippet] = 100,
			[CompletionItemKind.Text] = 101
		}

		-- Comparator: prefer kinds per table first
		local custom_kind_comparator = function(entry1, entry2)
			local p1 = kind_priorities[entry1:get_kind()] or 1000
			local p2 = kind_priorities[entry2:get_kind()] or 1000
			if p1 ~= p2 then
				return p1 < p2
			end
		end

		cmp.setup({
			-- disable automatic preselection; first visible item will be highlighted
			preselect = cmp.PreselectMode.None,
			-- ensure confirmation replaces by default (keeps behavior predictable)
			confirmation = { default_behavior = cmp.ConfirmBehavior.Replace },
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
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							if entry then
								cmp.confirm({ select = true })
							else
								-- no entry selected: insert newline
								fallback()
							end
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
				option = { get_bufnrs = vim.api.nvim_list_bufs }
			}, {
				name = 'path',
				priority = 900
			} }),
			sorting = {
				comparators = {
					custom_kind_comparator, -- keep your kind priorities first
					cmp.config.compare.exact, -- exact prefix wins
					cmp.config.compare.locality, -- proximity/locality (not CamelCase boundary boost)
					cmp.config.compare.sort_text, -- tie-break lexicographically
					cmp.config.compare.length, -- shorter names first
					cmp.config.compare.score, -- fuzzy scoring as fallback
					cmp.config.compare.order
				}
			}
		})
	end
}
