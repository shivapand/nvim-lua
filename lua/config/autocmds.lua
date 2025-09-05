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


vim.opt.sessionoptions:append('globals')
vim.api.nvim_create_autocmd(
  'User',
  {
    pattern = 'PersistenceSavePre',
    callback = function()
      vim.api.nvim_exec_autocmds(
        'User',
        { pattern = 'SessionSavePre' }
      )
    end,
  }
)


local buf_views = {}
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    buf_views[buf] = vim.fn.winsaveview()
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    local view = buf_views[buf]

    if view then
      vim.fn.winrestview(view)
    end
  end,
})
