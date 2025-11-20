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
			local project_root = util.root_pattern('package.json', '.git')(fname)
			if project_root then
				return vim.fn.fnamemodify(project_root, ':h')
			end
			return nil
		end

		-- Setup mason-lspconfig (disable automatic enable to use custom configs)
		require('mason-lspconfig').setup({
			automatic_installation = true,
			automatic_enable = false -- We'll set up manually with custom configs
		})

		-- Get installed servers and set them up
		local installed_servers =
			require('mason-lspconfig').get_installed_servers()

		-- Default handler for servers without custom config
		local default_handler = function(server_name)
			lspconfig[server_name].setup({})
		end

		-- Custom handlers
		local custom_handlers = {
			eslint = function()
				lspconfig.eslint.setup({
					root_dir = eslint_root_dir,
					settings = {
						workingDirectory = { mode = 'auto' }
					}
				})
			end,
			tsserver = function()
				lspconfig.tsserver.setup({
					filetypes = {
						'javascript',
						'javascriptreact',
						'typescript',
						'typescriptreact'
					}
				})
			end,
			html = function()
				lspconfig.html.setup({
					filetypes = { 'html' },
					settings = {
						html = {
							format = {
								indentInnerHtml = true,
								wrapLineLength = 120,
								wrapAttributes = 'auto'
							}
						}
					}
				})
			end,
			emmet_language_server = function()
				lspconfig.emmet_language_server.setup({
					filetypes = { 'scss', 'html' },
					settings = {
						emmet = {
							showExpandedAbbreviation = 'never',
							showAbbreviationSuggestions = false,
							showSuggestionsAsSnippets = false
						}
					}
				})
			end,
			cssls = function()
				lspconfig.cssls.setup({
					filetypes = { 'css', 'scss', 'sass', 'less' }
				})
			end,
			stylelint_lsp = function()
				lspconfig.stylelint_lsp.setup({
					filetypes = { 'css', 'scss', 'sass', 'less' },
					settings = {
						stylelint = {
							validateOnSave = true,
							lintOnSave = true
						}
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

		-- Setup all installed servers
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
