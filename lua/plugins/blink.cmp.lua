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
			}
			-- trigger = { show_on_trigger_character = false },
		},
		sources = {
			default = { 'lsp', 'path', 'buffer' },
			providers = {
				lsp = {
					fallbacks = {}
				},
				buffer = {
					opts = { get_bufnrs = function()
						return vim.tbl_filter(function(bufnr)
							return vim.bo[bufnr].buftype == ''
						end, vim.api.nvim_list_bufs())
					end }
				}
			}
		},
		fuzzy = { implementation = 'prefer_rust_with_warning' }
	},
	opts_extend = { 'sources.default' }
}
