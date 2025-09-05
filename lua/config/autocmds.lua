vim.opt.updatetime = 500

vim.api.nvim_create_autocmd(
  'CursorHold',
  {
    group = vim.api.nvim_create_augroup(
      'LspSagaDiagnostics',
      { clear = true }
    ),
    command = 'Lspsaga show_cursor_diagnostics ++unfocus',
    desc = 'Show LSP diagnostics on cursor hold',
  }
)


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


vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.*" },
  callback = function()
    vim.cmd("mkview")
  end,
  desc = "Save view on buffer/window leave",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.*" },
  callback = function()
    vim.cmd("silent! loadview")
  end,
  desc = "Load view on buffer/window enter",
})

vim.opt.sessionoptions:append 'globals'

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedSavePre',
  group = vim.api.nvim_create_augroup('PersistedHooks', {}),
  callback = function()
    vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
  end,
})
