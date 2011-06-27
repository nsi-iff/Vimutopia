call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Put line numbers
set number

" Syntax colored
syntax on
set background=dark

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

" (,[,{ Autocomplete
imap [ []<left>
imap ( ()<left>
imap { {}<left>

" Reload .vimrc file (F12)
map ,v :e $HOME/.vimrc /.vimutopia/vimrc-py.vim /.vimutopia/vimrc-c.vim<CR>
nmap <F12> : <C-u>source ~/.vimrc<CR>: <C-u>source ~/.vimutopia/vimrc-py.vim<CR>: <C-u>source ~/.vimutopia/vimrc-c.vim<CR>: echo "VIM's files reloaded"<CR>
imap <F12> <ESC>: <C-u>source ~/.vimrc<CR>: <C-u>source ~/.vimutopia/vimrc-py.vim<CR>: <C-u>source ~/.vimutopia/vimrc-c.vim<CR>a

" Hide search results
imap <S-F11> <ESC>:let @/=""<CR>a
nmap <S-F11> :let @/=""<CR>

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

" Undo
imap <C-z> <ESC>ua

" NerdTree
nmap <F2> :NERDTreeToggle<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>a

" Vimrcs to specific file types [added dynamically]
