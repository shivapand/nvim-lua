return {
  'echasnovski/mini.pairs',
  event = 'InsertEnter',
  config = function()
    require('mini.pairs').setup({
      mappings = {
        ['"'] = { register = { cr = true } },
        ["'"] = { register = { cr = true } },
      },
    })
  end,
}
