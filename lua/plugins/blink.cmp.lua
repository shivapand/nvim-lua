return {
	'saghen/blink.cmp',
	dependencies = { 'Exafunction/codeium.nvim' },
	version = '1.*',
	opts = {
		keymap = { preset = 'enter' },
		appearance = { nerd_font_variant = 'mono' },
		completion = {
			documentation = { auto_show = true },
			accept = {
				auto_brackets = { enabled = false }
			},
			trigger = { show_on_trigger_character = false }
		},
		sources = {
			default = { 'lsp', 'path', 'buffer', 'codeium' },
			providers = {
				lsp = {
					score_offset = 100,
					fallbacks = {}
				},
				codeium = {
					name = 'Codeium',
					module = 'codeium.blink',
					async = true,
					score_offset = -100,
					fallbacks = {}
				}
			}
		},
		fuzzy = {
			implementation = 'lua',
			sorts = { 'exact', 'score', 'sort_text' }
		}
	},
	opts_extend = { 'sources.default' }
}
