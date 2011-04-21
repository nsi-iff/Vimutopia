from should_dsl import should
import vimrc
import unittest


class TestVimrc(unittest.TestCase):
    """Test the vimrc python functions"""

    def test_used_text(self):
        vimrc.get_used_text("   aa") |should| equal_to("aa")
        vimrc.get_used_text("  a  b") | should| equal_to("b")

    def test_unused_text(self):
        vimrc.get_unused_text("   a") |should| equal_to("   ")

    def test_all_words(self):
        vimrc.get_all_words("hamburger and coke") |should| equal_to(["hamburger", "and", "coke"])
        vimrc.get_all_words("any_words, here") |should| equal_to(["any_words", "here"])

    def test_index_of_equals(self):
        vimrc.get_index_of_equals("cl", "class") |should| equal_to(2)
        vimrc.get_index_of_equals("claa", "class") |should| equal_to(3)

    def test_get_completation(self):
        vimrc.get_completation("class Foo(object): pass", "Fo") |should| equal_to("Foo")
        vimrc.get_completation("class classe", "cl") |should| equal_to("class")
