return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      mapping = {
        -- Confirm with Enter (like coc.nvim)
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Tab / Shift-Tab to cycle items
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "c" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "c" }),

        -- Arrow keys to cycle items (like coc.nvim)
        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "c" }),

        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "c" }),

        -- Ctrl+Space to trigger completion (like coc.nvim)
        ["<C-Space>"] = cmp.mapping.complete(),
      },

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            -- block all Emmet completions
            if entry.source.name == "nvim_lsp" and entry.completion_item.detail == "Emmet Abbreviation" then
              return false
            end
            return true
          end,
        },
        { name = "buffer" },
        { name = "path" },
      }),

    -- Behave like coc.nvim
    preselect = cmp.PreselectMode.Item,
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
    })
  end,
}
