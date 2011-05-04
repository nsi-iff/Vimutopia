#!/usr/bin/env python
# -*- coding: utf-8 -*-

from should_dsl import should
import scripts_generic
import unittest


class Testscripts_generic(unittest.TestCase):
    """Test the scripts_generic python functions"""

    def test_used_text(self):
        scripts_generic.get_used_text("   aa") |should| equal_to("aa")
        scripts_generic.get_used_text("  a  b") | should| equal_to("b")

    def test_unused_text(self):
        scripts_generic.get_unused_text("   a") |should| equal_to("   ")

    def test_all_words(self):
        scripts_generic.get_all_words("hamburger and coke") |should| equal_to(["hamburger", "and", "coke"])
        scripts_generic.get_all_words("any_words, here") |should| equal_to(["any_words", "here"])

    def test_index_of_equals(self):
        scripts_generic.get_index_of_equals("cl", "class") |should| equal_to(2)
        scripts_generic.get_index_of_equals("claa", "class") |should| equal_to(3)

    def test_get_completation(self):
        scripts_generic.get_completation("class Foo(object): pass", "Fo") |should| equal_to("Foo")
        scripts_generic.get_completation("class classe", "cl") |should| equal_to("class")
        scripts_generic.get_completation("class Foo", "class") |should| equal_to("class")
