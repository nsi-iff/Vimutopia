" Put line numbers
set number

" Syntax colored
syntax on

" Show ruler
set ruler

" Aliases
imap <c-right> <ESC>gta
imap <c-left> <ESC>gTa

nmap <c-right> gt
nmap <c-left> gT

" Vimrcs to specific file types
autocmd BufNewFile,BufRead *.py source $HOME/.vimrc-dumal/vimrc-py
