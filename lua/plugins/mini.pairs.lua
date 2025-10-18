return {
	'echasnovski/mini.pairs',
	event = 'VeryLazy',
	config = function()
		require('mini.pairs').setup({
			-- In which modes mappings from this `config` should be created
			modes = { insert = true, command = false, terminal = false },
			-- Global mappings. Each part will be the table of pairs [ [open, close] ]
			mappings = {
				['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
				['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
				['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
				['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
				['"'] = { action = 'open', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
				["'"] = { action = 'open', pair = "''", neigh_pattern = '[^\\].', register = { cr = false } },
				['`'] = { action = 'open', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
				[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
				[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
				['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
				['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
			},
			-- In which modes 'close' action should be mapped
			close_mappings = { [')'] = true, [']'] = true, ['}'] = true, ['>'] = true },
			-- In which modes 'open' action should be mapped
			open_mappings = { ['('] = true, ['['] = true, ['{'] = true, ['<'] = true },
		})
	end
}
