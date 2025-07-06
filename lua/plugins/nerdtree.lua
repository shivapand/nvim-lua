return {
  "preservim/nerdtree",
  enabled=false,
  config = function()
    local vimrc = vim.fn.stdpath("config") .. '/vim/nerdtree.vim'

    vim.cmd.source(vimrc)

    vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<CR>", {desc = 'Toggle NERDTree'})
  end,
}
