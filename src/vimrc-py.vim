" Auto-indentation
set autoindent

" Moving indentation
set smartindent cinwords=if,elif,else,for,while,try,except,finaly,def,class

" Set tab stop to 4
set tabstop=4

" Use < and > with 4 spaces
set shiftwidth=4

" Transform tabs in blankspaces
set expandtab

" Convert existent tabs
retab

python << EOF
import os
exec open(os.path.join(os.environ["HOME"], ".vimrc-dumal", "scripts", "scripts-python.py")).read()
EOF

" >>Aliases<<

" Specloud
imap <F5> <ESC>:wall<CR>:! clear; specloud; echo "Press enter to continue..."; read<CR>a
nmap <F5> :wall<CR>:! clear; specloud<CR>

" Ipython
imap <F9> <ESC>:! clear; ipython; echo -n "Press enter to continue..."; read<CR>a
nmap <F9> :! ipython<CR>

"parse to pep08
python parse2pep08()

"header
python create_header()

"create import for tests
python create_imports_for_tests()

" Help
"imap <F4> <ESC>:! clear; vim ~/.vimrc-dumal/help-py; echo "Press enter to continue..."; read<CR>a
"map <F4> :! clear; vim ~/.vimrc-dumal/help-py <CR>r
