return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "*",
	opts = {
		appearance = { nerd_font_variant = "mono" },
		completion = { documentation = { auto_show = true } },
		keymap = {
			preset = "enter",
			["<c-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<up>"] = { "select_prev", "fallback" },
			["<down>"] = { "select_next", "fallback" },
		},
		sources = {
			default = { "lazydev", "path", "lsp", "snippets", "buffer" },
			providers = {
				lazydev = {
					score_offset = 0,
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					fallbacks = {},
				},
				lsp = {
					score_offset = 0,
					min_keyword_length = 2,
					fallbacks = {},
				},
				path = {
					score_offset = 1,
					min_keyword_length = 0,
					fallbacks = {},
				},
				snippets = {
					score_offset = -1,
					min_keyword_length = 2,
					fallbacks = {},
				},
				buffer = {
					score_offset = 1,
					min_keyword_length = 2,
					opts = {
						get_bufnrs = vim.api.nvim_list_bufs,
					},
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
