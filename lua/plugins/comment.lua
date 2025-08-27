return {
  'numToStr/Comment.nvim',
  dependencies = {
    { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
  },
  config = function()
    require('Comment').setup({
      opleader = {
        line = 'cc',
        block = 'bb',
      },
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim')
          .create_pre_hook(),
    })
  end

}
