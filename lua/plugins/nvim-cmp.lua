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
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        -- Arrow keys to cycle items (like coc.nvim)
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

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
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
                  table.insert(bufs, buf)
                end
              end
              return bufs
            end
          }
        },
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
