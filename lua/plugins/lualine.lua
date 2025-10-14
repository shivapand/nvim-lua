return {
	'nvim-lualine/lualine.nvim',
	config = function(_)
		require('lualine').setup({
			sections = {
				lualine_a = {},
				lualine_b = { { 'branch' } },
				lualine_c = { {
					'filename',
					path = 1
				} },
				lualine_x = { 'diagnostics' },
				lualine_y = {},
				lualine_z = {}
			}
		})
	end
}
