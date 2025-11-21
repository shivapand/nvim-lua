return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup({
      check_ts = true,
      map_cr = true,
    })

    local Rule = require('nvim-autopairs.rule')
    npairs.add_rule(Rule('`', '`'))
  end,
}
