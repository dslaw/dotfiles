c = get_config()

c.TerminalIPythonApp.display_banner = False
c.TerminalIPythonApp.force_interact = True

c.InteractiveShellApp.exec_lines = [
    "import numpy as np",
    "q = lambda: quit()"
    ]
c.InteractiveShellApp.matplotlib = None
c.InteractiveShellApp.pylab_import_all = False

c.InteractiveShell.ast_node_interactivity = "all"
c.InteractiveShell.autocall = 2 # smart autocall
c.InteractiveShell.autoindent = True
c.InteractiveShell.automagic = False
c.InteractiveShell.color_info = True
c.InteractiveShell.colors = "Linux"

c.TerminalInteractiveShell.confirm_exit = False

