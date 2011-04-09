" Auto-indentation
set cindent

" Set tab stop to 4
set tabstop=4

" Use < and > with 4 spaces
set shiftwidth=4

" Transform tabs in blankspaces
set expandtab

" Convert existent tabs
retab

" Aliases
imap <F5> <ESC>:! clear; make; bash<CR>a
imap <F6> <ESC>:! clear; ./run_tests.sh; echo -n "Press enter to continue..."; read<CR>a

nmap <F5> :! clear; make; bash<CR>
nmap <F6> :! clear; ./run_tests.sh<CR>
