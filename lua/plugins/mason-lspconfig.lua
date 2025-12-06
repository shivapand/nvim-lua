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

		require('mason-tool-installer').setup({
			ensure_installed = {
				'lua-language-server',
				'eslint-lsp',
				'typescript-language-server',
				'prettier',
				'emmet-language-server',
				'html-lsp',
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

		require('mason-lspconfig').setup({
			automatic_installation = true,
			automatic_enable = false
		})

		local default_handler = function(server_name)
			lspconfig[server_name].setup({})
		end

		local custom_handlers = {
			eslint = function()
				lspconfig.eslint.setup({
					root_dir = eslint_root_dir,
					settings = {
						workingDirectory = { mode = 'auto' }
					}
				})
			end,
			jsonls = function()
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

		local installed_servers =
			require('mason-lspconfig').get_installed_servers()

		for _, server_name in ipairs(installed_servers) do
			if custom_handlers[server_name] then
				custom_handlers[server_name]()
			else
				default_handler(server_name)
			end
		end

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
	end
}
