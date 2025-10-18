return {
	'mason-org/mason-lspconfig.nvim',
	version = '*',
	dependencies = { {
		'mason-org/mason.nvim',
		version = '*',
		opts = {}
	}, {
		'neovim/nvim-lspconfig',
		version = '*'
	}, {
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		version = '*'
	}, { 'b0o/schemastore.nvim' } },
	config = function()
		local lspconfig = require('lspconfig')
		local util = require('lspconfig.util')

		vim.diagnostic.config({
			severity_sort = true,
			float = {
				border = 'rounded',
				source = 'if_many'
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '󰅚 ',
					[vim.diagnostic.severity.WARN] = '󰀪 ',
					[vim.diagnostic.severity.INFO] = '󰋽 ',
					[vim.diagnostic.severity.HINT] = '󰌶 '
				}
			},
			update_in_insert = true,
			virtual_text = false
		})

		require('mason-tool-installer').setup({
			ensure_installed = {
				'lua-language-server',
				'eslint-lsp',
				'typescript-language-server',
				'prettier',
				'emmet-language-server',
				'css-lsp',
				'stylelint-lsp',
				'json-lsp'
			}
		})

		local function eslint_root_dir(fname)
			local root = util.root_pattern('eslint.config.mjs')(fname)

			if root then
				local parent = vim.fn.fnamemodify(root, ':h')
				if vim.fn.filereadable(parent .. '/eslint.config.mjs') == 1 then
					return parent
				end
			end

			return root
		end

		lspconfig.eslint.setup({
			root_dir = eslint_root_dir,
			settings = {
				workingDirectory = { mode = 'auto' }
			}
		})

		lspconfig.ts_ls.setup({
			filetypes = {
				'javascript',
				'javascriptreact',
				'typescript',
				'typescriptreact'
			}
		})

		lspconfig.emmet_language_server.setup({
			filetypes = { 'scss', 'html', 'javascript' }
		})

		lspconfig.jsonls.setup({
			settings = {
				json = {
					schemas = require('schemastore').json.schemas(),
					validate = { enable = true }
				}
			}
		})
	end
}
