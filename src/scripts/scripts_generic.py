#!/usr/bin/env python
# -*- coding: utf-8 -*-
#!/usr/bin/python
# -*- coding: utf-8 -*-

import commands
import re
try:
    import vim

    def auto_complete():
        line, row = vim.current.window.cursor
        if row:
            word = get_used_text(vim.current.line[:row + 1])
            unused = get_unused_text(vim.current.line[:row + 1])
        else:
            word = ""
            unused = ""
            row -= 1
        if word:
            content = "\n".join(vim.current.buffer)
            completed = get_completation(content, word)
        else:
            completed = "    "
        vim.current.line = unused + completed + vim.current.line[row + 1:]
        vim.current.window.cursor = (line, row + len(completed))
except ImportError:
    # Isn't in vim. Probably this is a test.
    pass

def paste():
    line, row = vim.current.window.cursor
    for line_text in commands.getoutput("xclip -o").split("\n"):
        vim.current.buffer.append(line_text)

def get_all_words(text):
    words = []
    for line in text.split("\n"):
        words_of_line = [match.group() for match in re.finditer("[A-Za-z_]+", line)]
        words.extend(words_of_line)
    return words

def get_completation(text, used_text):
    words = get_all_words(text)
    completed = ""
    for word in words:
        if word.startswith(used_text) and word != used_text:
            if completed:
                index = get_index_of_equals(completed, word)
                completed = word[:index]
            else:
                completed = word
    if completed:
        return completed
    else:
        return used_text

def get_index_of_equals(text1, text2):
    for index, letter1 in enumerate(text1):
        if index < len(text2) - 1:
            if text2[index] != letter1:
                return index
    return min(len(text1), len(text2))

def get_used_text(text):
    match = re.search("[A-Za-z_]+$", text)
    if match == None:
        return ""
    used = text[match.start():]
    return used

def get_unused_text(text):
    match = re.search("[A-Za-z_]+$", text)
    if match == None:
        return text
    unused = text[:match.start()]
    return unused

