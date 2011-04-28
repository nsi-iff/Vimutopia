#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from should_dsl import should
from scripts_python import (revise_spaces_in_expressions, revise_name_class, revise_two_points,
revise_spaces_in_end_of_line)


class Testpython(unittest.TestCase):

    def test_remove_spaces_in_expressions(self):
        revise_spaces_in_expressions("spam( ham[ 1 ], { eggs: 2 } )") |should| equal_to("spam(ham[1], {eggs: 2})")
        revise_spaces_in_expressions("dict ['key'] = list [index]") |should| equal_to("dict['key'] = list[index]")

    def test_capitalize_clasname_in_line_with_class_definition(self):
        revise_name_class("class foo():") |should| equal_to("class Foo():")
        revise_name_class("a = b + 1") |should| equal_to("a = b + 1")
        revise_name_class("class Foo():") |should| equal_to("class Foo():")
        revise_name_class("class FooFoo():") |should| equal_to("class FooFoo():")

    def test_remove_spaces_after_two_points(self):
        revise_two_points("def foo()   :") |should| equal_to("def foo():")
        revise_two_points("def foo():") |should| equal_to("def foo():")

    def test_remove_spaces_before_two_points(self):
        revise_two_points("def foo():     ") |should| equal_to("def foo(): ")
        revise_two_points("def foo(): print") |should| equal_to("def foo(): print")

    def test_remove_in_final_line(self):
        revise_spaces_in_end_of_line("a = b + 1    ") |should| equal_to("a = b + 1")
        revise_spaces_in_end_of_line("a = b + 1") |should| equal_to("a = b + 1")
