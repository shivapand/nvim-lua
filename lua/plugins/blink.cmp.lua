return {
	'saghen/blink.cmp',
	version = '*',
	opts = {
		appearance = { nerd_font_variant = 'mono' },
		completion = {
			documentation = { auto_show = true },
			accept = {
				auto_brackets = { enabled = false }
			},
			list = {
				selection = { auto_insert = false } -- Do not automatically insert on selection
			}
		},
		keymap = {
			preset = 'enter',
			['<c-space>'] = {
				'show',
				'show_documentation',
				'hide_documentation'
			},
			['<tab>'] = { 'select_next', 'fallback' },
			['<s-tab>'] = { 'select_prev', 'fallback' },
			['<up>'] = { 'select_prev', 'fallback' },
			['<down>'] = { 'select_next', 'fallback' }
		},
		sources = {
			default = { 'path', 'buffer', 'lazydev', 'lsp' },
			providers = {
				path = {
					fallbacks = {}
				},
				buffer = { score_offset = -1 },
				lazydev = {
					name = 'LazyDev',
					module = 'lazydev.integrations.blink',
					fallbacks = {}
				},
				lsp = {
					fallbacks = {}
				}
			}
		},
		fuzzy = { implementation = 'prefer_rust' }
	},
	opts_extend = { 'sources.default' }
}
