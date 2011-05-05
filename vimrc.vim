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
set listchars=eol:¬,trail:▸,tab:\ \ 

" Use the mouse
set mouse=a

" Activate backspace to delete characters
set backspace=2

" Dynamic search
set incsearch
set hlsearch

if has("python")
python << EOF
import os
exec open(os.path.join(os.environ["HOME"], ".vimutopia", "scripts", "scripts_generic.py")).read()
EOF
endif

" >> Aliases <<

" Hide search results
imap <S-F11> <ESC>:let @/=""<CR>a
nmap <S-F11> :let @/=""<CR>

" Copy a text to this file
vmap <C-c> ya

" Paste a text from this file
imap <C-v> <ESC>pa
nmap <C-v> p

if has("python")
	" Auto-complete words
	imap <TAB> <ESC>:python auto_complete()<CR>a
endif

" Open a new tab
imap <C-t> <ESC> :tabnew 
nnoremap <C-t>     :tabnew 

" Move between tabs
imap <C-Right> <ESC>:tabnext<CR>a
imap <C-Left> <ESC>:tabprevious<CR>a
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left>  :tabprevious<CR>

" Save
imap <C-w> <ESC>:w<CR>a
nnoremap <C-w> :w<CR>

" Undo
imap <C-z> <ESC>ua

" Vimrcs to specific file types [added dynamically]
