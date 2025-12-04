return {
	'saghen/blink.cmp',
	dependencies = {},
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
			default = { 'lsp', 'path', 'buffer' },
			providers = {
				lsp = {
					fallbacks = {},
					score_offset = 2
				}
			}
		},
		fuzzy = { implementation = 'lua' }
	},
	opts_extend = { 'sources.default' }
}
