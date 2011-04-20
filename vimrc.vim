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
import commands
import vim
import re

def paste():
    line, row = vim.current.window.cursor
    for line_text in commands.getoutput("xclip -o").split("\n"):
        vim.current.buffer.append(line_text)

def get_all_words():
    words = []
    for line in vim.current.buffer:
        words_of_line = [match.group() for match in re.finditer("[A-Za-z_]+", line)]
        for word in words_of_line:
            words.append(word)
    return words

def get_completation(text):
    words = get_all_words()
    completed = ""
    for word in words:
        if word.startswith(text) and word != text:
            if completed:
                index = get_index_of_equals(completed, word)
                completed = word[:index]
            else:
                completed = word
    return completed

def get_index_of_equals(text1, text2):
    for index, letter1 in enumerate(text1):
        if index < len(text2) - 1:
            if text2[index] != letter1:
                return index
    return min(len(text1), len(text2))

def get_used_text(text):
    match = re.search("[A-Za-z_]+$", text)
    if match != None:
        unused = text[:match.start()]
        used = text[match.start():]
        return unused + "%s", used
    return text + "%s", ""

def auto_complete():
    line, row = vim.current.window.cursor
    text = vim.current.buffer[line - 1]
    unused_text, used_text = get_used_text(text)
    text = get_completation(used_text)
    if used_text:
        if text:
            vim.current.buffer[line - 1] = unused_text % text
            vim.current.window.cursor = (line, len(unused_text % text))
    else:
        vim.current.buffer[line - 1] = "    " + unused_text % used_text
        vim.current.window.cursor = (line, row + 4)
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
