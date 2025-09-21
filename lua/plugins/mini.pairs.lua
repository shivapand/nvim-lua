return {
  "echasnovski/mini.pairs",
  event = "InsertEnter", -- lazy-load on insert
  config = function()
    require('mini.pairs').setup({
      -- default mappings are automatically applied, so you can omit `mappings`
      -- but if you want to add a custom one like "surround":
      mappings = {
        -- wrap text in parentheses with Alt+e
        ['<M-e>'] = { action = 'surround', pair = '()' },
      },
    })
  end
}
