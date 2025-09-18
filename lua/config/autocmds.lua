vim.api.nvim_create_autocmd(
  'BufReadPost',
  {
    group = vim.api.nvim_create_augroup(
      'OilRelativePathFix',
      { clear = true }
    ),
    callback = function()
      vim.cmd('cd `pwd`')
    end,
    desc = 'Fix for Oil opening files with absolute-path'
  }
)
