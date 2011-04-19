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

" >>>Aliases<<<

" Compile and run
imap <F8> <ESC>:w<CR>:! clear; gcc % -o %:r; chmod +x ./%:r; ./%:r<CR>
nmap <F8> :w<CR>:! clear; gcc % -o %:r; chmod +x ./%:r; ./%:r<CR>

" Run
imap <F9> <ESC>:! clear; ./%:r<CR>
nmap <F9> :! clear; ./%:r<CR>
