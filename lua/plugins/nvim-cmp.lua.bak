return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path"
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      mapping = {
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
        { name = "path" }
      },
      preselect = cmp.PreselectMode.Item,
      completion = { completeopt = "menu,menuone,noinsert" },
      window = { documentation = cmp.config.window.bordered() }
    })
  end
}
