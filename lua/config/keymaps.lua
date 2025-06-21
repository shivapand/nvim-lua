vim.keymap.set({ 'i', 'n' }, '<C-s>', '<ESC>:w<CR>', { desc = 'Save file' })

vim.keymap.set('n', '<Leader>j', ':execute "tabmove" tabpagenr() - 2<CR>', { desc = 'Move tab prev' })
vim.keymap.set('n', '<Leader>k', ':execute "tabmove" tabpagenr() + 1<CR>', { desc = 'Move tab next' })

vim.keymap.set('n', '<Leader>/', ':noh<CR>', { desc = 'Clear search highlight' })

vim.keymap.set('n', '<Leader>g', ':call system("xclip -i -selection clipboard", expand("%:~:."))<CR>',
  { desc = 'Copy file path' })
