#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import re
try:
    import vim
except ImportError:
    pass

WORD_CHARS = r"A-Za-z_"

RE_WORD_CHAR = r"[%s]" % WORD_CHARS
RE_NOT_WORD_CHAR = r"[^%s]" % WORD_CHARS

def to_be_completed(text, words):
    if not text:
        return False
    for word in words:
        if word.startswith(text):
            return True
    return False

def text_to_complete(text):
    match = re.search("(%s+)$" % RE_WORD_CHAR, text)
    if match == None:
        return ""
    return match.groups()[0]

def text_to_not_complete(text):
    match = re.search("^(.*%s)%s*$" % (RE_NOT_WORD_CHAR, RE_WORD_CHAR), text)
    if match == None:
        return ""
    return match.groups()[0]

def all_words(text):
    words = []
    for match in re.finditer("%s+" % RE_WORD_CHAR, text):
        word = match.group()
        if word not in words:
            words.append(word)
    return words

def _index_of_equals(text1, text2):
    for index, letter1 in enumerate(text1):
        if index < len(text2):
            if text2[index] != letter1:
                return index
    return min(len(text1), len(text2))

def complete(text, words):
    completed = ""
    for word in words:
        if word.startswith(text):
            if completed:
                index = _index_of_equals(completed, word)
                completed = word[:index]
            else:
                completed = word
    return completed

def auto_complete():
    line, row = vim.current.window.cursor
    if row:
        to_complete = text_to_complete(vim.current.line[:row + 1])
        to_not_complete = text_to_not_complete(vim.current.line[:row + 1])
    else:
        to_complete = ""
        to_not_complete = ""
        row -= 1
    if to_complete:
        content = "\n".join(vim.current.buffer)
        words = all_words(content)
        if to_complete in words:
            words.remove(to_complete)
        completed = complete(to_complete, words) or to_complete
    else:
        completed = "    "
    vim.current.line = to_not_complete + completed + vim.current.line[row + 1:]
    vim.current.window.cursor = (line, row + len(completed) - len(to_complete))
