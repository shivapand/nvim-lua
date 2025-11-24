return {
	'saghen/blink.cmp',
	dependencies = {
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets',
		'lazydev.nvim'
	},
	version = '1.*',
	opts = {
		keymap = {
			snippets = { preset = 'luasnip' },
			preset = 'enter',
			['<C-e>'] = { 'hide', 'show' }
		},
		appearance = { nerd_font_variant = 'mono' },
		completion = {
			documentation = { auto_show = false },
			trigger = { show_on_trigger_character = false },
			accept = {
				auto_brackets = { enabled = false }
			}
		},
		sources = {
			default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
			providers = {
				lazydev = {
					name = 'LazyDev',
					module = 'lazydev.integrations.blink',
					score_offset = 100
				}
			}
		},
		fuzzy = { implementation = 'prefer_rust_with_warning' }
	},
	opts_extend = { 'sources.default' }
}
