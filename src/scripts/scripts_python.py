#!/usr/bin/python
# -*- coding: utf-8 -*-

#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rlcompleter
try:
    import vim
    cb = vim.current.buffer
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
    words = [match.group() for match in re.finditer("[A-Za-z_]+", line)]
    if words:
        if (words[0] == "import") and (len(words) > 2):
            cb[i] = "import " + words[1]
            for ind, imp in enumerate(words[2:]):
                cb.append("import " + imp, i + ind + 1)

def revise_header():
    if cb[0] != "#!/usr/bin/env python":
        cb.append("#!/usr/bin/env python", 0)
    if cb[1] != "# -*- coding: utf-8 -*-":
        cb.append("# -*- coding: utf-8 -*-", 1)
        cb.append("")

def revise_name_class(line, i):
    words = [match.group() for match in re.finditer("[A-Za-z_]+", line)]
    if words:
        if words[0] == "class":
            cb[i] = line.replace(words[1],  words[1].capitalize())

def revise_parenthesis(line):
    while "( " in line:
        line = line.replace("( ", "(")
    while " )" in line:
        line = line.replace(" )", ")")
    return line

def parse2pep08():
    revise_header()
    for i,line in enumerate(cb):
        revise_name_class(line, i)
        revise_imports(line, i)
        vim.current.buffer[i] = revise_parenthesis(line)

def insert_header():
    vim.current.buffer[0] = "#!/usr/bin/env python"
    vim.current.buffer.append("# -*- coding: utf-8 -*-")
    vim.current.buffer.append("")

def create_imports_for_tests():
    full_filename = cb.name
    filename = full_filename.split("/")[-1]
    name = get_program_name(filename)
    if filename.find("spec") != -1 and cb[2] == "" and len(cb) < 5:
        cb[len(cb)-1] = "import unittest"
        cb.append("from should_dsl import should")
        cb.append("from " + name + " import ")
        cb.append("")
        cb.append("class Test" + name.capitalize() + "(unittest.TestCase):")
        vim.command(":w")
        vim.current.window.cursor = (6, len(cb[-1]))
        vim.command("tabnew " + name + ".py")
        insert_header()
        vim.command(":w")
        vim.command("tabp")

