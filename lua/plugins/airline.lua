return {
  'vim-airline/vim-airline',
  dependencies = { 
    'vim-airline/vim-airline-themes'
  },
  config = function() 
    local vimrc = vim.fn.stdpath("config") .. '/vim/airline.vim'

    vim.cmd.source(vimrc)
  end
}
