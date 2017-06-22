from IPython import __version__ as ipython_version
from os import environ
from sys import version_info


banner = "Python {version} | IPython {ipy_version} | {env}\n".format(
    version=".".join(map(str, version_info[:3])),
    ipy_version=ipython_version,
    env=environ.get("CONDA_DEFAULT_ENV", "root")
)

c = get_config()
c.InteractiveShell.banner1 = banner
c.InteractiveShell.automagic = False
c.InteractiveShell.color_info = True
c.InteractiveShellApp.exec_lines = ["q = lambda: quit()"]
c.TerminalInteractiveShell.confirm_exit = False
