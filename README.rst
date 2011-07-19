========================
Vimutopia
========================

This project was created to help programmers, providing them a complete tool that supports various languages, including python, C and (coming soon) others. It had been developed in Information Systems Research Group ISRg [#]_.

Some considerations
====================


These files will replace your vimrc in /home.

General configuration:

-  Line numbers enabled
-  Colored syntax with dark background
-  Show statusbar
-  Markup characters delimiting blankspaces and end of line
-  Mouse support enabled (for those who like to use it)
-  Dynamic search
-  Drag line across the file using arrow keys
-  Different colors to statusbar in insert mode ans normal mode
-  Hide search results with shift+F11
-  Auto-complete for previously typed words
-  Open a new tab using Ctrl+t
-  Move between tabs using Ctrl+'arrow keys'
-  Most of shortcuts are enabled both to normal and insert mode


Installing
=================

To install you have to run in terminal:

    # ./install_dependencies.sh - 

    $ ./install.sh


Python specifications
========================

For Python codes will be installed some packages.

-  Ipython [#]_: Iterative Python shell
-  Should_dsl [#]_: Tool to create high level tests
-  Specloud [#]_: Tool tests to run it more cleanly
-  Pip [#]_:  Tool to install Python packages
-  Python-dev [#]_: PyDev is a Python IDE for Eclipse, which may be used in Python, Jython and IronPython development.

Shortcuts:

-  Specloud = <F5>
-  Ipython = <F9>
-  Run current file with python = <F7>

Some more considerations:

-  Smart identation according to keywords
-  All Tabs in opened files are converted into spaces
-  One Tab is converted to four blank spaces
-  All files are formated according to PEP8


C specifications
=======================

For C codes will be installed some packages

- gcc [#]_: Compiler package for C and others languages

Shortcuts:

-  Compile and run the current file = <F9>
-  Just run the current file = <F5>
-  Interactive GCC = <F6>
-  Just compile the current file = <F7>

Some more considerations:

-  Smart indentation according to C patterns
-  All tabs are converted into four blank spaces


Links
========================

.. [#] http://nsi.iff.edu.br/
.. [#] http://ipython.scipy.org/moin/ 
.. [#] http://www.should-dsl.info/
.. [#] http://pypi.python.org/pypi/specloud
.. [#] http://www.pip-installer.org/en/latest/
.. [#] http://pydev.org/
.. [#] http://gcc.gnu.org/
