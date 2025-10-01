return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    local kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰇽",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    -- Custom status color source
    local statusDefinitionCollection = {
      { text = "generated", color = "#145DE4" },
      { text = "resolved",  color = "#72FFE6" },
      { text = "ignored",   color = "#FF778F" },
    }

    local status_source = {}
    status_source.new = function()
      return setmetatable({}, { __index = status_source })
    end

    status_source.get_trigger_characters = function()
      return { ":" }
    end

    status_source.complete = function(self, params, callback)
      local items = {}
      for _, status in ipairs(statusDefinitionCollection) do
        table.insert(items, {
          label = status.color,
          insertText = status.color,
          kind = cmp.lsp.CompletionItemKind.Color,
          documentation = status.text,
        })
      end
      callback({ items = items, isIncomplete = false })
    end

    status_source.resolve = function(self, item, callback)
      callback(item)
    end

    cmp.register_source("status_source", status_source.new())

    cmp.setup({
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

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

        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-Space>"] = cmp.mapping.complete(),

        ["<Right>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      sources = {
        {
          name = "nvim_lsp",
          entry_filter = function(entry)
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
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.tbl_filter(function(buf)
                return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
        { name = "path" },
        { name = "status_source", priority = 100 },
      },

      preselect = cmp.PreselectMode.Item,
      completion = { completeopt = "menu,menuone,noinsert" },
      window = { documentation = cmp.config.window.bordered() },
      experimental = { ghost_text = true },

      formatting = {
        format = function(entry, vim_item)
          -- Show full text for all sources
          vim_item.abbr = entry:get_insert_text() or entry.completion_item.label
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

          if entry.source.name == "luasnip" and not vim_item.abbr:match("~$") then
            vim_item.abbr = vim_item.abbr .. "~"
          end

          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[S]",
            buffer = "[B]",
            path = "[P]",
            status_source = "[C]",
          })[entry.source.name]

          return vim_item
        end,
      },
    })
  end,
}
