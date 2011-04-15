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
import rlcompleter
import vim

def get_used_text(text):
    match = re.search("^(?P<unused> *)(?P<used>.*)$", text)
    unused = match.groupdict()["unused"]
    used = match.groupdict()["used"]
    return unused + "%s", used

def get_completation(text):
    if text:
        completer = rlcompleter.Completer()
        text_completed = ""
        state = 0
        completed = ""
        while completed != None:
            completed = completer.complete(text, state)
            state += 1
            if text_completed:
                if completed:
                    index = get_index_of_equals(text_completed, completed)
                    text_completed = completed[:index]
            else:
                text_completed = completed
        return text_completed
EOF

" >>Aliases<<

" Specloud
imap <F5> <ESC>:w<CR>:! clear; specloud; echo "Press enter to continue..."; read<CR>a
nmap <F5> :w<CR>:! clear; specloud<CR>

" Ipython
imap <F9> <ESC>:! clear; ipython; echo -n "Press enter to continue..."; read<CR>a
nmap <F9> :! ipython<CR>

" Help
"imap <F4> <ESC>:! clear; vim ~/.vimrc-dumal/help-py; echo "Press enter to continue..."; read<CR>a
"map <F4> :! clear; vim ~/.vimrc-dumal/help-py <CR>
