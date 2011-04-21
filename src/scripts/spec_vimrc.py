from should_dsl import should
import vimrc
import unittest


class TestVimrc(unittest.TestCase):
    """Test the vimrc python functions"""

    def test_test_used_text(self):
        vimrc.get_used_text("   aa") |should| equal_to("aa")
