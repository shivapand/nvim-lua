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

vim.o.updatetime = 300

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
