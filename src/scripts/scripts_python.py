#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rlcompleter
try:
    import vim
except ImportError:
    # Isn't in vim. Probably this is a test.
    pass
import os
import sys
import re

def get_program_name(test_name):
    name = test_name.split(".")[0]
    name = "".join(("".join(name.split("spec_")).split("_spec")))
    return "".join(("".join(name.split("spec-")).split("-spec")))

def revise_imports(line, i):
    words = [match.group() for match in re.finditer("[A-Za-z_.]+", line)]
    if words:
        if(words[0] == "import") and (len(words) > 2):
            line = "import " + words[1]
            for ind, imp in enumerate(words[2:]):
                vim.current.buffer.append("import " + imp, i + ind + 1)
    return line

def revise_header():
    if vim.current.buffer[0] != "#!/usr/bin/env python":
        vim.current.buffer.append("#!/usr/bin/env python", 0)
    if vim.current.buffer[1] != "# -*- coding: utf-8 -*-":
        vim.current.buffer.append("# -*- coding: utf-8 -*-", 1)
        vim.current.buffer.append("", 2)

def revise_name_class(line):
    words = [match.group() for match in re.finditer("[A-Za-z_]+", line)]
    if words:
        if words[0] == "class" and len(words) > 1:
            name_class = words[1][0].capitalize() + words[1][1:]
            return line.replace(words[1], name_class)
    return line

def revise_two_points(line):
    line = line.split("\"")
    for i in range(0, len(line), 2):
        while " :" in line[i]:
            line[i] = line[i].replace(" :", ":")
        while ":  " in line[i]:
            line[i] = line[i].replace(":  ", ": ")
        line[i] = re.sub(r": (-?\d)", r":\1", line[i])
    return "\"".join(line)

def revise_spaces_in_end_of_line(line):
    while line.endswith(" "):
        line = line[:-1]
    return line

def revise_spaces_around_equals(line):
    line = line.split("\"")
    for i in range(0, len(line), 2):
        line[i] = re.sub(r" *(==|!=|>=|<=|=|\+=|-=|\*=) *", r" \1 ", line[i])
    return "\"".join(line)

def revise_spaces_around_operators(line):
    line = line.split("\"")
    for i in range(0, len(line), 2):
        if not(line[i].startswith("#")):
            line[i] = re.sub(r" *(>=|<=|\+=|-=|\*=|\+|\-|\*\*|\*|>|<|%) *", r" \1 ", line[i])
            line[i] = re.sub(r"= *- (\d.\d|\d) *", r"= -\1 ", line[i])
            line[i] = re.sub(r" *(\d) *- *(\d) *", r" \1 - \2", line[i])
    return "\"".join(line)

def revise_spaces_in_expressions(line):
    line = line.split("\"")
    for i in range(0, len(line), 2):
        for caracter1, caracter2 in [["(", ")"], ["[", "]"], ["{", "}"]]:
            while caracter1 + " " in line[i]:
                line[i] = line[i].replace(caracter1 + " ", caracter1)
            while " " + caracter2 in line[i]:
                line[i] = line[i].replace(" " + caracter2, caracter2)
        line[i] = re.sub(" *, *", ", ", line[i])
        line[i] = re.sub(r"(\)|\]|}|\d) *(or|and|in) *(\(|\[|\{|\d)", r"\1 \2 \3", line[i])
        line[i] = re.sub(r" +(and|or|in) +", r" \1 ", line[i])
    return "\"".join(line)

def parse2pep08():
    revise_header()
    for i, line in enumerate(vim.current.buffer):
        line = revise_imports(line, i)
        line = revise_name_class(line)
        line = revise_spaces_around_equals(line)
        line = revise_spaces_around_operators(line)
        line = revise_spaces_in_expressions(line)
        line = revise_two_points(line)
        line = revise_spaces_in_end_of_line(line)
        vim.current.buffer[i] = line

def insert_header():
    vim.current.buffer[0] = "#!/usr/bin/env python"
    vim.current.buffer.append("#-*- coding: utf-8 -*-")
    vim.current.buffer.append("")

def create_imports_for_tests():
    full_filename = vim.current.buffer.name
    filename = full_filename.split("/")[-1]
    name = get_program_name(filename)
    if filename.find("spec") != -1 and vim.current.buffer[2] == "" and len(vim.current.buffer) < 5:
        vim.current.buffer[len(vim.current.buffer) -1] = "import unittest"
        vim.current.buffer.append("from should_dsl import should")
        vim.current.buffer.append("from " + name + " import ")
        vim.current.buffer.append("")
        vim.current.buffer.append("")
        vim.current.buffer.append("class Test" + name.capitalize() + "(unittest.TestCase):")
        vim.command(":w")
        vim.current.window.cursor = (6, len(vim.current.buffer[-1]))
        vim.command("tabnew " + name + ".py")
        insert_header()
        vim.command(":w")
        vim.command("tabp")
