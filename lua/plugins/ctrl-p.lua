return {
  'kien/ctrlp.vim',
  config = function()
    local vimrc = vim.fn.stdpath("config") .. '/vim/ctrl-p.vim'

    vim.cmd.source(vimrc)
  end
}
