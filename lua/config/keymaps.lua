vim.keymap.set(
  { 'i', 'n' },
  '<C-s>',
  '<ESC>:silent w<CR>',
  {
    desc = 'Save file',
    silent = true
  }
)

vim.keymap.set(
  'n',
  '<Leader>/', ':noh<CR>',
  {
    desc = 'Clear search highlight',
    silent = true
  }
)

vim.keymap.set(
  'n',
  '<Leader>g',
  function()
    vim.fn.setreg('+', vim.fn.expand('%:~:.'))
  end,
  {
    desc = 'Copy file path',
    silent = true,
  }
)

vim.keymap.set(
  'n',
  '-',
  '<CMD>Oil --float<CR>',
  { desc = 'Open parent directory' }
)

vim.keymap.set(
  'n',
  '<Leader>j',
  ':execute "tabmove" tabpagenr() - 2<CR>',
  { desc = 'Move tab prev' }
)
vim.keymap.set(
  'n',
  '<Leader>k',
  ':execute "tabmove" tabpagenr() + 1<CR>',
  { desc = 'Move tab next' }
)
