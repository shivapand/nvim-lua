return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '*',
  opts = {
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        update_delay_ms = 50,
        treesitter_highlighting = true
      }
    },
    keymap = {
      preset = 'enter',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<Tab>'] = {
        function(cmp)
          return cmp.select_next()
        end,
        'snippet_forward',
        'fallback'
      },
      ['<S-Tab>'] = {
        function(cmp)
          return cmp.select_prev()
        end,
        'snippet_backward',
        'fallback'
      },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' }
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          score_offset = 0,
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          fallbacks = {}
        },
        lsp = {
          score_offset = 0,
          min_keyword_length = 2,
          fallbacks = {}
        },
        path = {
          score_offset = 3,
          min_keyword_length = 0,
          fallbacks = {}
        },
        snippets = {
          score_offset = -1,
          min_keyword_length = 2,
          fallbacks = {}
        },
        buffer = {
          score_offset = 3,
          min_keyword_length = 4,
          opts = {
            get_bufnrs = vim.api.nvim_list_bufs
          }
        }
      }
    },
    signature = {
      enabled = true
    }
  }
}
