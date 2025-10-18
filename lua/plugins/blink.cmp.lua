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
			default = { 'lazydev', 'lsp', 'path', 'buffer' },
			providers = {
				lazydev = {
					name = 'LazyDev',
					module = 'lazydev.integrations.blink',
					score_offset = 3,
					min_keyword_length = 1,
					fallbacks = {}
				},
				lsp = {
					score_offset = 2,
					min_keyword_length = 1,
					fallbacks = {}
				},
				path = {
					score_offset = 1,
					min_keyword_length = 0,
					fallbacks = {}
				},
				buffer = {
					score_offset = 0,
					min_keyword_length = 1
				}
			}
		},
		fuzzy = { implementation = 'prefer_rust' }
	},
	opts_extend = { 'sources.default' }
}
