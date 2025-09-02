return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '*',
  opts = {
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
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
          min_keyword_length = 2,
          opts = {
            get_bufnrs = vim.api.nvim_list_bufs
          }
        }
      }
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        function(a, b)
          -- Prioritize items that are NOT from emmet_ls
          if a.client_name == 'emmet_language_server' and
              b.client_name ~= 'emmet_language_server' then
            return false -- 'a' (emmet) comes after 'b' (non-emmet)
          elseif a.client_name ~= 'emmet_language_server' and
              b.client_name == 'emmet_language_server' then
            return true -- 'a' (non-emmet) comes before 'b' (emmet)
          end

          -- If both are emmet or both are non-emmet,
          -- or if client_name is not available, fall back to other sorts
          return nil
        end,
        'score',     -- Fallback to score-based sorting
        'sort_text', -- Fallback to sort_text
      },
    }
  },
  opts_extend = { "sources.default" }
}
