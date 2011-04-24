#!/usr/bin/python
# -*- coding: utf-8 -*-

import rlcompleter
import vim
import os
import sys

def get_used_text(text):
    match = re.search("^(?P<unused> *)(?P<used>.*)$", text)
    unused = match.groupdict()["unused"]
    used = match.groupdict()["used"]
    return unused + "%s", used

def get_program_name(test_name):
    name = test_name.split(".")[0]
    name = "".join(("".join(name.split("spec_")).split("_spec")))
    return "".join(("".join(name.split("spec-")).split("-spec")))

def create_header():
    if vim.current.buffer[0]=="":
        vim.current.buffer[0] = "#!/usr/bin/python"
        vim.current.buffer.append("# -*- coding: utf-8 -*-")
        vim.current.buffer.append("")
        vim.current.buffer.append("")
        vim.current.window.cursor = (4,0)

def parse2pep08():
    for i, line in enumerate(vim.current.buffer):
         words = line.split(" ")
         if words[0] == "class":
             words[1] = words[1].capitalize() 
             new_line = ""
             for word in words:
                 new_line += word + " "
             vim.current.buffer[i] = new_line

def create_imports_for_tests():
    full_filename = vim.current.buffer.name
    filename = full_filename.split("/")[-1]
    name = get_program_name(filename)
    if filename.find("spec") != -1 and vim.current.buffer[2] == "":
        vim.current.buffer[len(vim.current.buffer)-1] = "import unittest"
        vim.current.buffer.append("from should_dsl import should")
        vim.current.buffer.append("from " + name + " import ")
        vim.current.buffer.append("")
        vim.current.buffer.append("class Test" + name.capitalize() + "(unittest.TestCase):")
        vim.current.window.cursor = (6,len(vim.current.buffer[-1]))
        vim.command("tabnew " + name + ".py")
        create_header()
        vim.command(":w")
        vim.command("tabp")

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
