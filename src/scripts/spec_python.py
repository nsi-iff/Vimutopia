#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
import os
from should_dsl import should
from python import(revise_spaces_in_expressions, revise_name_class, revise_two_points,
revise_spaces_in_end_of_line, revise_spaces_around_equals, revise_spaces_around_operators,
namespace, update_namespace, complete, get_module_names)


class TestPythonComplete(unittest.TestCase):

    def tearDown(self):
        namespace.clear()

    def it_updates_namespace_by_module_names(self):
        namespace |should| equal_to({})
        update_namespace(module_names=["os"])
        namespace |should| equal_to({"os": os})

    def it_knows_modules_of_a_file(self):
        get_module_names("import os") |should| equal_to(["os"])
        get_module_names("import os\nimport sys") |should| equal_to(["os", "sys"])

    def it_completes_module_attributes(self):
        update_namespace(module_names=["os"])
        complete("os.syst") |should| equal_to("os.system(")
        complete("os.sysc") |should| equal_to("os.sysconf")
        complete("os.sysconf_") |should| equal_to("os.sysconf_names")


class Testpython(unittest.TestCase):

    def test_remove_spaces_in_expressions(self):
        revise_spaces_in_expressions("spam( ham[1 ], { eggs: 2})") |should| equal_to("spam(ham[1], {eggs: 2})")
        revise_spaces_in_expressions("dict['key' ] = list[index]") |should| equal_to("dict['key'] = list[index]")
        revise_spaces_in_expressions("\"spam(ham[1]\", { eggs: 2})") |should| equal_to("\"spam(ham[1]\", {eggs: 2})")
        revise_spaces_in_expressions("if (a > 1)and(b < 7)") |should| equal_to("if (a > 1) and (b < 7)")
        revise_spaces_in_expressions("if a > 1   and   b < 7") |should| equal_to("if a > 1 and b < 7")

    def test_capitalize_clasname_in_line_with_class_definition(self):
        revise_name_class("class foo():") |should| equal_to("class Foo():")
        revise_name_class("a = b + 1") |should| equal_to("a = b + 1")
        revise_name_class("class Foo():") |should| equal_to("class Foo():")
        revise_name_class("class FooFoo():") |should| equal_to("class FooFoo():")

    def test_remove_spaces_after_two_points(self):
        revise_two_points("def foo() :") |should| equal_to("def foo():")
        revise_two_points("def foo():  ") |should| equal_to("def foo(): ")
        revise_two_points("[: -1]") |should| equal_to("[:-1]")

    def test_remove_spaces_before_two_points(self):
        revise_two_points("def foo(): ") |should| equal_to("def foo(): ")
        revise_two_points("def foo(): print") |should| equal_to("def foo(): print")

    def test_remove_spaces_in_end_line(self):
        revise_spaces_in_end_of_line("a = b + 1    ") |should| equal_to("a = b + 1")
        revise_spaces_in_end_of_line("a = b + 1") |should| equal_to("a = b + 1")

    def test_remove_more_than_one_space_around_of_equals(self):
        revise_spaces_around_equals("a  =  a + 1") |should| equal_to("a = a + 1")
        revise_spaces_around_equals("a\" = \"a + 1") |should| equal_to("a\" = \"a + 1")
        revise_spaces_around_equals("a = \"a + -5 \"") |should| equal_to("a = \"a + -5 \"")

    def test_revise_spaces_around_operators(self):
        revise_spaces_around_operators("a = a+2") |should| equal_to("a = a + 2")
        revise_spaces_around_operators("a = a + 2") |should| equal_to("a = a + 2")
        revise_spaces_around_operators("a = \"a + \" 2") |should| equal_to("a = \"a + \" 2")
        revise_spaces_around_operators("a = \"a + -5 \"") |should| equal_to("a = \"a + -5 \"")
        revise_spaces_around_operators("a = -   5") |should| equal_to("a = -5 ")
        revise_spaces_around_operators("a = -   5.7") |should| equal_to("a = -5.7 ")
        revise_spaces_around_operators("a = 2  -5") |should| equal_to("a = 2 - 5")
        revise_spaces_around_operators("#-*-") |should| equal_to("#-*-")

