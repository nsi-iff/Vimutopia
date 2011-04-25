#!/usr/bin/python
# -*- coding: utf-8 -*-

import rlcompleter
import vim
import os
import sys
import re

def get_program_name(test_name):
    name = test_name.split(".")[0]
    name = "".join(("".join(name.split("spec_")).split("_spec")))
    return "".join(("".join(name.split("spec-")).split("-spec")))

def revise_header():
    if vim.current.buffer[0] != "#!/usr/bin/python":
        vim.current.buffer.append("#!/usr/bin/python", 0)
    if vim.current.buffer[1] != "# -*- coding: utf-8 -*-":
        vim.current.buffer.append("# -*- coding: utf-8 -*-", 1)
        vim.current.buffer.append("", 2)

def revise_name_class(line, i):
    words = [match.group() for match in re.finditer("[A-Za-z_]+", line)]
    if words:
        if words[0] == "class":
            vim.current.buffer[i] = line.replace(words[1], words[1].capitalize())

def parse2pep08():
    for i, line in enumerate(vim.current.buffer):
        revise_name_class(line, i)
        revise_header()

def create_imports_for_tests():
    full_filename = vim.current.buffer.name
    filename = full_filename.split("/")[-1]
    name = get_program_name(filename)
    if filename.find("spec") != -1 and vim.current.buffer[2] == "" and len(vim.current.buffer) < 5:
        vim.current.buffer[len(vim.current.buffer)-1] = "import unittest"
        vim.current.buffer.append("from should_dsl import should")
        vim.current.buffer.append("from " + name + " import ")
        vim.current.buffer.append("")
        vim.current.buffer.append("class Test" + name.capitalize() + "(unittest.TestCase):")
        vim.command(":w")
        vim.current.window.cursor = (6,len(vim.current.buffer[-1]))
        vim.command("tabnew " + name + ".py")
        revise_header()
        vim.command(":w")
        vim.command("tabp")
