#!/usr/bin/python
# -*- coding: utf-8 -*-

import unittest
from should_dsl import should
from scripts_python import revise_parenthesis


class TestPython(unittest.TestCase):

    def test_remove_spaces_after_parenthesis(self):
        revise_parenthesis("  (  a)") |should| equal_to("  (a)")

    def test_remove_spaces_before_parenthesis(self):
        revise_parenthesis("  (a  )") |should| equal_to("  (a)")
