let g:coc_global_extensions = ['coc-tsserver', 'coc-git', 'coc-pairs', 'coc-emmet', 'coc-eslint', 'coc-prettier', 'coc-stylelintplus', 'coc-css', 'coc-styled-components']

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nnoremap <C-a> :CocCommand prettier.formatFile<CR>

nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)

nmap <Esc> :call coc#float#close_all() <CR>

vmap <leader>a  <Plug>(coc-format-selected)
nmap <leader>a  <Plug>(coc-format-selected)
