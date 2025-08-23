set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_show_hidden=1

let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command=['.git/','git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:ctrlp_open_new_file="t"
