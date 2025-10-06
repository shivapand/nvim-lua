return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  opts = {
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true },
      accept = { 
        auto_brackets = {
          enabled = false
        }
      }
    },
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
          score_offset = 1,
          min_keyword_length = 3,
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          fallbacks = {},
        },
        lsp = {
          score_offset = 1,
          min_keyword_length = 3,
          fallbacks = {},
        },
        path = {
          score_offset = 2,
          min_keyword_length = 1,
          fallbacks = {},
        },
        snippets = {
          score_offset = 0,
          min_keyword_length = 3,
          fallbacks = {},
        },
        buffer = {
          score_offset = 2,
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        function(a, b)
          if a.client_name == 'emmet_language_server' and
              b.client_name ~= 'emmet_language_server' then
            return false
          elseif a.client_name ~= 'emmet_language_server' and
              b.client_name == 'emmet_language_server' then
            return true
          end

          return nil
        end,
        'score',
        'sort_text'
      }
    },
  },
  opts_extend = { "sources.default" },
}
