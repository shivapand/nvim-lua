return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Optional: icon mapping
    local kind_icons = {
      Text = "",
      Method = "ƒ",
      Function = "",
      Variable = "",
      Field = "ﰠ",
      Class = "",
    }

    cmp.setup({
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Right arrow to accept ghost text
        ["<Right>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      -- Sources
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            -- filter Emmet in JS/TS/React to avoid "x.y:" / "<window:>"
            local ft = vim.bo.filetype
            if entry.source.name == "nvim_lsp"
                and entry.completion_item.detail == "Emmet Abbreviation"
                and (ft == "javascript" or ft == "javascriptreact"
                  or ft == "typescript" or ft == "typescriptreact") then
              return false
            end
            return true
          end,
        },
        { name = "luasnip" },
        { name = "buffer", option = { get_bufnrs = vim.api.nvim_list_bufs } },
        { name = "path" },
      }),

      -- Preselect like CoC
      preselect = cmp.PreselectMode.Item,

      -- Auto-popup
      completion = {
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        completeopt = "menu,menuone,noinsert",
      },

      -- Documentation popup
      window = {
        documentation = cmp.config.window.bordered(),
      },

      -- Ghost text like CoC
      experimental = {
        ghost_text = true,
      },

      -- Clean formatting: abbr, icon, menu
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[B]",
            path = "[P]",
            luasnip = "[S]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
  end,
}
