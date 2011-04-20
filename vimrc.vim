" Put line numbers
set number

" Syntax colored
syntax on

" Show ruler
set ruler

" Show statusbar with 2 lines
set laststatus=2

" Show markup characters
set list
set listchars=eol:¬,trail:▸

" Use the mouse
set mouse=a

" Activate backspace to delete characters
set backspace=2

" Dynamic search
set incsearch
set hlsearch

" Hide search results
imap <S-F11> <ESC>:let @/=""<CR>a
nmap <S-F11> :let @/=""<CR>

python << EOF
import os
exec open(os.path.join(os.environ["HOME"], ".vimrc-dumal", "scripts", "vimrc.py")).read()
EOF

" >> Aliases <<

" Copy a text to this file
vmap <C-c> ya

" Paste a text from this file
imap <C-v> <ESC>pa
nmap <C-v> p

" Auto-complete words
imap <TAB> <ESC>:python auto_complete()<CR>a

" Open a new tab
nnoremap <C-t>     :tabnew 

" Move between tabs
imap <C-Right> <ESC>:tabnext<CR>a
imap <C-Left> <ESC>:tabprevious<CR>a
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left>  :tabprevious<CR>

" Save
imap <C-w> <ESC>:w<CR>a
nnoremap <C-w> :w<CR>

" Vimrcs to specific file types [added dynamically]
