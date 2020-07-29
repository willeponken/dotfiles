config.source("theme-nord.py")

c.auto_save.session = True
c.downloads.location.directory = "~/downloads/"
c.fonts.default_family = "Consolas"
c.fonts.default_size = "13px"
c.tabs.padding = {"bottom": 1, "left": 5, "right": 5, "top": 1}

config.unbind("J", mode="normal")
config.unbind("K", mode="normal")

config.bind("H", "tab-prev")
config.bind("L", "tab-next")

config.bind("u", "back")
config.bind("<Ctrl-R>", "forward")

config.bind("<Ctrl-v>", "spawn mpv {url}")
