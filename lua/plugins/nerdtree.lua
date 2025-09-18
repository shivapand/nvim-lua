return {
  "preservim/nerdtree",
  config = function()
    local vimrc = vim.fn.stdpath("config") .. '/vim/nerdtree.vim'

    vim.cmd.source(vimrc)

  end,
}
