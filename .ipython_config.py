# https://ipython.readthedocs.org/en/latest/config/options/terminal.html

c = get_config()

c.TerminalIPythonApp.display_banner = False
c.TerminalIPythonApp.force_interact = True

c.InteractiveShellApp.exec_files = []
c.InteractiveShellApp.exec_lines = [
    "from __future__ import division, print_function",
    "import numpy as np",
    "import pandas as pd",
    "q = lambda: quit()"
    ]
c.InteractiveShellApp.extensions = []
c.InteractiveShellApp.matplotlib = None
c.InteractiveShellApp.pylab_import_all = False

c.InteractiveShell.ast_node_interactivity = "all"
c.InteractiveShell.autocall = 2 # smart autocall
c.InteractiveShell.autoindent = True
c.InteractiveShell.automagic = False
c.InteractiveShell.color_info = True
c.InteractiveShell.colors = "Linux"
c.InteractiveShell.editor = "vim"

c.TerminalInteractiveShell.confirm_exit = False

lambda_char = u'\u03bb'
c.PromptManager.in_template = "{color.Green}" + lambda_char + " > "
c.PromptManager.in2_template = "{color.Green}... "
c.PromptManager.out_template = "{color.Blue}<<< "
c.PromptManager.justify = True

