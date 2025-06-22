let g:coc_global_extensions = ['coc-tsserver', 'coc-git', 'coc-pairs', 'coc-emmet', 'coc-eslint', 'coc-prettier', 'coc-stylelintplus', 'coc-css', 'coc-styled-components', 'coc-lua']

command! -nargs=0 Prettier :CocCommand prettier.formatFile
