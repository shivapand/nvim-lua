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
					score_offset = 2,
					fallbacks = {}
				},
				codeium = {
					name = 'Codeium',
					module = 'codeium.blink',
					async = true,
					score_offset = -1000,
					fallbacks = {}
				}
			}
		},
		fuzzy = { implementation = 'lua' }
	},
	opts_extend = { 'sources.default' }
}
