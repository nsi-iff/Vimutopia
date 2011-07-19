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
imap <F9> <ESC>:w<CR>:! clear; gcc % -o %:r; chmod +x ./%:r; ./%:r<CR>
nmap <F9> :w<CR>:! clear; gcc % -o %:r; chmod +x ./%:r; ./%:r<CR>

" Compile
imap <F7> <ESC>:w<CR>:! clear; gcc % -o %:r;<CR>
nmap <F7> :w<CR>:! clear; gcc % -o %:r;<CR>

" Run
imap <F5> <ESC>:! clear; ./%:r<CR>
nmap <F5> :! clear; ./%:r<CR>

" igcc
imap <F6> <ESC>:! clear; ~/.vimutopia/igcc/igcc; echo -n "Press enter to continue..."; read<CR>a
nmap <F6> :! ~/.vimutopia/igcc/igcc<CR>
