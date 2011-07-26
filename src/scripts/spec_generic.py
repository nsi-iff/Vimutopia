#!/usr/bin/env python
# -*- coding: utf-8 -*-

from should_dsl import should
import generic
import unittest


class TestAutoComplete(unittest.TestCase):
    """Test the auto-complete feature"""

    def setUp(self):
        self.words = ["abc", "cba", "cbb", "abcd"]

    def it_knows_if_needs_to_complete(self):
        generic.to_be_completed("", self.words) |should| be(False)
        generic.to_be_completed("a", self.words) |should| be(True)
        generic.to_be_completed("d", self.words) |should| be(False)

    def it_knows_the_text_to_complete(self):
        generic.text_to_complete("") |should| equal_to("")
        generic.text_to_complete("a") |should| equal_to("a")
        generic.text_to_complete(" a") |should| equal_to("a")
        generic.text_to_complete("\ta") |should| equal_to("a")

    def it_knows_the_text_to_not_complete(self):
        generic.text_to_not_complete("") |should| equal_to("")
        generic.text_to_not_complete("  ") |should| equal_to("  ")
        generic.text_to_not_complete("a") |should| equal_to("")
        generic.text_to_not_complete("  a") |should| equal_to("  ")
        generic.text_to_not_complete("  ab") |should| equal_to("  ")
        generic.text_to_not_complete("  ab a") |should| equal_to("  ab ")

    def it_knows_all_words_in_a_text(self):
        generic.all_words("a b c") |should| equal_to(["a", "b", "c"])
        generic.all_words("a b b") |should| equal_to(["a", "b"])

    def it_completes_words(self):
        generic.complete("a", self.words) |should| equal_to("abc")
        generic.complete("c", self.words) |should| equal_to("cb")
        generic.complete("abc", self.words) |should| equal_to("abc")
